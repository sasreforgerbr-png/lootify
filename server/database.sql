CREATE TABLE IF NOT EXISTS `lootify_inventories` (
  `owner` VARCHAR(64) NOT NULL,
  `name` VARCHAR(32) NOT NULL DEFAULT 'player',
  `data` LONGTEXT,
  PRIMARY KEY (`owner`, `name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
