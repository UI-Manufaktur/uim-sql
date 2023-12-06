module langs.sql.sqlparsers.builders.position;

import lang.sql;

@safe:

// Builds positions of the GROUP BY clause. 
class PositionBuilder : ISqlBuilder {

  string build(Json parsedSql) {
    if (!parsedSql.isExpressionType("POSITION")) {
      return "";
    }
    
    return parsedSql.baseExpression;
  }
}
