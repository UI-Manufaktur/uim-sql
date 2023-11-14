
/**
 * ReplaceProcessor.php
 *
 * This file : the processor for the REPLACE statements. 
 */

module lang.sql.parsers.processors;

import lang.sql;

@safe:

// This class processes the REPLACE statements. 
class ReplaceProcessor : InsertProcessor {

    auto process($tokenList, $token_category = 'REPLACE') {
        return super.process($tokenList, $token_category);
    }

}
