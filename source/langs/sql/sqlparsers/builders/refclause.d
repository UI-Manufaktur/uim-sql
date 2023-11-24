module langs.sql.sqlparsers.builders.refclause;

import lang.sql;

@safe:

/**
 * Builds reference clauses within a JOIN.
 * This class : the references clause within a JOIN.
 */
class RefClauseBuilder : ISqlBuilder {

    

    string build(Json parsedSql) {
        if (parsedSql.isEmpty) { return ""; }

        string mySql = "";
        foreach (myKey, myValue; parsedSql) {
            size_t oldSqlLength = mySql.length;
            mySql ~= this.buildColRef(myValue);
            mySql ~= this.buildOperator(myValue);
            mySql ~= this.buildConstant(myValue);
            mySql ~= this.buildFunction(myValue);
            mySql ~= this.buildBracketExpression(myValue);
            mySql ~= this.buildInList(myValue);
            mySql ~= this.buildColumnList(myValue);
            mySql ~= this.buildSubQuery(myValue);

            if (oldSqlLength == mySql.length) { // No change
                throw new UnableToCreateSQLException("expression ref_clause", myKey, myValue, "expr_type");
            }

            mySql ~= " ";
        }
        return substr(mySql, 0, -1);
    }protected string buildInList(Json parsedSql) {
        auto myBuilder = new InListBuilder();
        return myBuilder.build(parsedSql);
    }

    protected string buildColRef(Json parsedSql) {
        auto myBuilder = new ColumnReferenceBuilder();
        return myBuilder.build(parsedSql);
    }

    protected string buildOperator(Json parsedSql) {
        auto myBuilder = new OperatorBuilder();
        return myBuilder.build(parsedSql);
    }

    protected string buildFunction(Json parsedSql) {
        auto myBuilder = new FunctionBuilder();
        return myBuilder.build(parsedSql);
    }

    protected string buildConstant(Json parsedSql) {
        auto myBuilder = new ConstantBuilder();
        return myBuilder.build(parsedSql);
    }

    protected string buildBracketExpression(Json parsedSql) {
        auto myBuilder = new SelectBracketExpressionBuilder();
        return myBuilder.build(parsedSql);
    }

    protected string buildColumnList(Json parsedSql) {
        auto myBuilder = new ColumnListBuilder();
        return myBuilder.build(parsedSql);
    }

    protected string buildSubQuery(Json parsedSql) {
        auto myBuilder = new SubQueryBuilder();
        return myBuilder.build(parsedSql);
    }
}
