module langs.sql.sqlparsers.builders.update.update;

import lang.sql;

@safe:

// Builds the UPDATE statement parts. 
class UpdateBuilder : ISqlBuilder {

    protected string buildTable(parsedSql, string idx) {
        auto myBuilder = new TableBuilder();
        return myBuilder.build(parsedSql, idx);
    }

    string build(Json parsedSql) {
        string mySql = "";

        foreach (myKey, myValue; parsedSql) {
            size_t oldSqlLength = mySql.length;
            mySql ~= this.buildTable(myValue, $k);

            if (oldSqlLength == mySql.length) { // No change
                throw new UnableToCreateSQLException("UPDATE table list", myKey, myValue, "expr_type");
            }
        }
        return "UPDATE " ~ mySql;
    }
}
