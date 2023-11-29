module langs.sql.sqlparsers.processors.create;

import lang.sql;

@safe:

/**
 * This file : the processor for the CREATE statements.
 * This class processes the CREATE statements.
 */
class CreateProcessor : AbstractProcessor {

    auto process( mytokens) {
         myresult = myExpression = [];
        string baseExpression = "";

        foreach (myToken;  mytokens) {
            
            auto strippedToken = myToken.strip;
            baseExpression ~= myToken;

            if (strippedToken.isEmpty) {
                continue;
            }

            upperToken = strippedToken.toUpper;
            switch (upperToken) {

            case "TEMPORARY":
                // CREATE TEMPORARY TABLE
                 myresult["expr_type"] .isExpressionType("TEMPORARY_TABLE");
                 myresult["not-exists"] = false;
                myExpression ~= createExpression("RESERVED", "base_expr" : strippedToken];
                break;

            case "TABLE":
                // CREATE TABLE
                 myresult["expr_type"] =  expressionType("TABLE");
                 myresult["not-exists"] = false;
                myExpression ~= createExpression("RESERVED"), "base_expr" : strippedToken);
                break;

            case "INDEX":
                // CREATE INDEX
                 myresult["expr_type"] .isExpressionType(INDEX;
                myExpression ~= createExpression("RESERVED", "base_expr" : strippedToken);
                break;

            case "UNIQUE":
            case "FULLTEXT":
            case "SPATIAL":
                // options of CREATE INDEX
                 myresult["base_expr"] =  myresult["expr_type"] = false;
                 myresult["constraint"] = upperToken; 
                myExpression ~= createExpression("RESERVED"), "base_expr" : strippedToken);
                break;                
                                
            case "IF":
                // option of CREATE TABLE
                myExpression ~= createExpression("RESERVED"), "base_expr" : strippedToken);
                break;

            case "NOT":
                // option of CREATE TABLE
                myExpression ~= createExpression("RESERVED"), "base_expr" : strippedToken);
                break;

            case "EXISTS":
                // option of CREATE TABLE
                 myresult["not-exists"] = true;
                myExpression ~= createExpression("RESERVED"), "base_expr" : strippedToken);
                break;

            default:
                break;
            }
        }
         myresult["base_expr"] = baseExpression.strip;
         myresult["sub_tree"] = myExpression;
        return  myresult;
    }
}