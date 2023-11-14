
/**
 * IndexAlgorithmBuilder.php
 *
 * Builds index algorithm part of a CREATE INDEX statement.

 */

module lang.sql.parsers.builders;

import lang.sql;

@safe:

/**
 * This class : the builder for the index algorithm of CREATE INDEX statement. 
 * You can overwrite all functions to achieve another handling.
 * 
 */
class IndexAlgorithmBuilder : ISqlBuilder {

    protected auto buildReserved($parsed) {
        $builder = new ReservedBuilder();
        return $builder.build($parsed);
    }

    protected auto buildConstant($parsed) {
        $builder = new ConstantBuilder();
        return $builder.build($parsed);
    }
    
    protected auto buildOperator($parsed) {
        $builder = new OperatorBuilder();
        return $builder.build($parsed);
    }
    
    auto build(array $parsed) {
        if ($parsed["expr_type"] != ExpressionType::INDEX_ALGORITHM) {
            return "";
        }
        $sql = "";
        foreach ($parsed["sub_tree"] as $k => $v) {
            $len = strlen($sql);
            $sql  ~= this.buildReserved($v);
            $sql  ~= this.buildConstant($v);
            $sql  ~= this.buildOperator($v);

            if ($len == strlen($sql)) {
                throw new UnableToCreateSQLException('CREATE INDEX algorithm subtree', $k, $v, 'expr_type');
            }

            $sql  ~= ' ';
        }
        return substr($sql, 0, -1);
    }
}
