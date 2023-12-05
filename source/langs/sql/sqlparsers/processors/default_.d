module langs.sql.sqlparsers.processors.default_;

import lang.sql;

@safe:

// This class processes the incoming sql string.
class DefaultProcessor : AbstractProcessor {

  protected auto isUnion( mytokens) {
    return UnionProcessor::isUnion( mytokens);
  }

  protected auto processUnion( mytokens) {
    // this is the highest level lexical analysis. This is the part of the
    // code which finds UNION and UNION ALL query parts
    auto myProcessor = new UnionProcessor(this.options);
    return myProcessor.process( mytokens);
  }

  protected auto processSQL( mytokens) {
    auto myProcessor = new SQLProcessor(this.options);
    return myProcessor.process( mytokens);
  }

  auto process( mysql) {

    auto myInputArray = this.splitSQLIntoTokens( mysql);
    auto myQueries = this.processUnion(myInputArray);

    // If there was no UNION or UNION ALL in the query, then the query is
    // stored at myQueries[0].
    if (!empty(myQueries) && !this.isUnion(myQueries)) {
     myQueries = this.processSQL(myQueries[0]);
    }

    return myQueries;
  }

  auto revokeQuotation( mysql) {
    return super.revokeQuotation( mysql);
  }
}



?  > 