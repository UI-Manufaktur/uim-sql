module langs.sql.sqlparsers.builders.create.tables.check;

import lang.sql;

@safe:

/**
 * Builds the CHECK statement part of CREATE TABLE. 
 * This class : the builder for the CHECK statement part of CREATE TABLE. 
 * You can overwrite all functions to achieve another handling. */
class CheckBuilder : ISqlBuilder {

    protected auto buildSelectBracketExpression(parsedSQL) {
        auto myBuilder = new SelectBracketExpressionBuilder();
        return myBuilder.build(parsedSQL);
    }

    protected auto buildReserved(parsedSQL) {
        auto myBuilder = new ReservedBuilder();
        return myBuilder.build(parsedSQL);
    }

    string build(Json parsedSQL) {
        if (!parsedSQL["expr_type"].isExpressionType("CHECK")) {
            return "";
        }

        // Main
        string mySql = "";
        foreach (myKey, myValue; parsedSQL["sub_tree"]) {
            size_t oldSqlLength = mySql.length;
            mySql ~= 
                buildReserved(myValue) ~
                buildSelectBracketExpression(myValue);

            if (oldSqlLength == mySql.length) { // No change
                throw new UnableToCreateSQLException("CREATE TABLE check subtree", myKey, myValue, "expr_type");
            }

            mySql ~= " ";
        }

        return substr(mySql, 0, -1);
    }
}
