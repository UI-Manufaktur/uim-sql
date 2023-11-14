
module source.langs.sql.PHPSQLParser.builders.drop.index;

import lang.sql;

@safe:
/**
 * This class : the builder for the DROP INDEX statement. You can overwrite
 * all functions to achieve another handling. */
class DropIndexBuilder : IBuilder {

	protected auto buildIndexTable($parsed) {
		auto myBuilder = new DropIndexTableBuilder();
		return myBuilder.build($parsed);
	}

    string build(array $parsed) {
        $sql = $parsed["name"];
	    $sql = trim($sql);
	    $sql  ~= " " ~ this.buildIndexTable($parsed);
        return trim($sql);
    }
}
