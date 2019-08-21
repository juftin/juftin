"""PRIMARY METHODS FOR INTERACTIONS WITH SQL OBJECTS."""

from re import sub

from pandas import read_sql
from sqlalchemy import MetaData, Table, create_engine, text
from sqlalchemy.exc import NoSuchTableError, ProgrammingError
from tabulate import tabulate


class SQL:
    """METHODS FOR SQL OPERATION."""

    def __init__(self, connection_string):
        engine = create_engine(connection_string)
        self.engine = engine

    @staticmethod
    def pretty_print(dataframe):
        """PRINT A TABULAR DATAFRAME"""
        print(tabulate(dataframe, headers="keys",
                       tablefmt="presto", showindex=True))

    def read_sql(self, query):
        """FETCH THE DATA AND RETURN RAW DATAFRAME."""
        conn = self.engine.connect()
        dataframe = read_sql(query, con=conn)
        conn.close()
        return dataframe

    def execute(self, sql):
        """EXECUTE SQL COMMANDS."""
        conn = self.engine.connect()
        try:
            conn.execute(text(sql).execution_options(autocommit=True))
        except ProgrammingError:
            pass
        conn.close()

    def delete(self, table, schema, condition):
        """EXECUTE SQL COMMANDS."""
        conn = self.engine.connect()
        try:
            delete = "DELETE FROM " + schema + "." + table + "WHERE " + \
                condition
            conn.execute(text(delete).execution_options(autocommit=True))
        except ProgrammingError:
            pass
        conn.close()

    def vacuum(self):
        """VACUUM DATABASE."""
        conn = self.engine.connect()
        conn.execute("VACUUM")
        conn.close()

    def to_sql(self, dataframe, table_name, if_exists="fail",
               index=False, chunksize=None, dtype=None, schema=None):
        """LOAD DATAFRAME INTO DATABASE, FAILS IF TABLE EXISTS BY DEFAULT."""
        conn = self.engine.connect()
        if chunksize is None:
            chunksize = int(len(dataframe) / 10)
            if chunksize == 0:
                chunksize = len(dataframe)
        dataframe.to_sql(table_name, con=conn, index=index,
                         if_exists=if_exists, chunksize=chunksize,
                         dtype=dtype, schema=schema)
        conn.close()

    @staticmethod
    def to_csv(dataframe, file_path, header=True, index=False, delimiter=",",
               encoding="utf-8", quotechar='"', quoting=1):
        """STANDARDIZED CSV EXPORT."""
        dataframe.to_csv(file_path, header=header, index=index, sep=delimiter,
                         encoding=encoding, quotechar=quotechar,
                         quoting=quoting)

    @staticmethod
    def rename_columns(dataframe):
        """RENAME COLUMNS, REPLACE NON ALPHANUMERIC WITH "_"."""
        dataframe.rename(columns=lambda x:
                         sub('[^0-9a-zA-Z]+', '_', x), inplace=True)

    def get_dtype(self, table_name):
        """GET DTYPE DICTIONARY FROM TABLE."""
        try:
            table = Table(table_name, MetaData(), autoload=True,
                          autoload_with=self.engine)
            dtype_dict = {}
            for column in table.c:
                dtype_dict[column.name] = column.type
        except NoSuchTableError:
            dtype_dict = None
        return dtype_dict

    def reinsert_data(self, dtype_dict, table_name, constraint_sql=None):
        """ACOUNT FOR NEW COLUMNS BY INSERTING OLD DATA INTO STAGING TABLE,
        DROPPING OLD TABLE, RENAME STAGING TABLE TO NEW TABLE, AND
        REAPPLYING CONSTRAINTS IF NECCESARY."""
        conn = self.engine.connect()
        if dtype_dict:
            column_list = [key for key, value in dtype_dict.items()]
            column_blob = ",\n".join(map(str, column_list))
            insert_query = "INSERT INTO " + table_name + "_temporary (" + \
                column_blob + ") SELECT " + column_blob + " FROM " + table_name
            conn.execute(insert_query)
            conn.execute("DROP TABLE " + table_name)
        conn.execute("ALTER TABLE " + table_name +
                     "_temporary RENAME TO " + table_name)
        if constraint_sql is not None:
            conn.execute(constraint_sql)
        conn.close()

    def get_var(self, table, var, where=None):
        """GET VARIABLE FROM SQL DATABASE."""
        conn = self.engine.connect()
        if where is None:
            where = "1=1"
        if "MAX" not in var:
            var = '"' + var + '"'
        try:
            result = conn.execute(
                "SELECT DISTINCT " + var + " FROM " +
                table + " WHERE " + where)
            variable = result.fetchone()[0]
        except (TypeError, ProgrammingError):
            variable = None
        conn.close()
        return variable

    @staticmethod
    def reporting_string(msa_yml, yaml_object="default_database"):
        """CREATE A REPORTING DB CONNECTION STRING FROM MSA.YML."""
        conn_str = "mysql://" + msa_yml[yaml_object]["username"] + \
            ":" + msa_yml[yaml_object]["password"] + \
            "@" + msa_yml[yaml_object]["host"] + "/" + \
            msa_yml[yaml_object]["database_name"] + "?charset=utf8"
        return conn_str
