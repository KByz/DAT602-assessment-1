DROP SCHEMA IF EXISTS dust2dust;
CREATE SCHEMA dust2dust;

USE dust2dust;

DROP TABLE IF EXISTS `tile`;
DROP TABLE IF EXISTS `inventory`;
DROP TABLE IF EXISTS `item`;
DROP TABLE IF EXISTS `npc`;
DROP TABLE IF EXISTS `grid`;
DROP TABLE IF EXISTS `map`;
DROP TABLE IF EXISTS `game`;
DROP TABLE IF EXISTS `character`;
DROP TABLE IF EXISTS `user_account`;

/*
 GAME, MAP, GRID
 A game of Dust2Dust comes into existance when at least one player enters a game. 
 From that point the game will be active and any other players will join the game on that ID. A single game can handle up to 10 players at once. 
 When a character attempts to join a game excessive of 10 players, a new game will be generated for that player to enter. 

 */

CREATE TABLE `game`(
	`gameID` INT PRIMARY KEY,
	`runtime` TIME NULL,
	`status` VARCHAR(10) NOT NULL
);


CREATE TABLE `map`(
	`mapID` INT PRIMARY KEY,
	`gameID` INT,
	FOREIGN KEY (`gameID`) REFERENCES `game` (`gameID`)	
);


CREATE TABLE `grid`(
	`gridID` INT PRIMARY KEY,
	`mapID` INT,
	FOREIGN KEY (`mapID`) REFERENCES `map` (`mapID`)	
);
/*
 USER_ACCOUNT TABLE DROP AND CREATION
 The purpose of the user_account table is to create and store accounts for player and admin-level users of the game. 
 Each account is identified by a unique username (PK) and requires a unique email. 
 The email, though a candidate key, cannot be used as the username will be public to other players and would be a breach of privacy. 
 Only the user's first name is nessessary.
 The account type distingusihes standard player from administrator level abilities in the system
 
 */

CREATE TABLE `user_account`(
	`username` VARCHAR(50) PRIMARY KEY UNIQUE,
	`email` VARCHAR(255) UNIQUE,
	`password` VARCHAR(100),
	`firstName` VARCHAR(100),
	`accountType` VARCHAR(25),
	`status` VARCHAR(25),
	`attempts` INT (3)
);

/*
 CHARACTER TABLE DROP AND CREATION
 The purpose of the character table is to store both static and dynamic data on a player character including
 the character name (unique, PK), the player's username (FK), their base/current health during an active game, 
 score during an active game, highest score earned, the status of the character (active or inactive), the id of the game they are active in,
 the time of their last attack, application of an attack cooldown, 
 a timer for their last movement, and an AFK check which will log them out of the game from the server side if inactive for too long

 */

CREATE TABLE `character`(
	`username` VARCHAR(50) PRIMARY KEY, 
	`gameID` INT NULL,
	`status` VARCHAR (10),
	`health` INT(4),
	`currentScore` INT(10),
	`highScore` INT(10),
	`lastAttack` TIME,
	`attackCooldown` VARCHAR (10),
	`invincibility` VARCHAR (10),
	`lastMove` TIME,
	`afk` VARCHAR (10),
	FOREIGN KEY (`username`) REFERENCES `user_account` (`username`),
	FOREIGN KEY (`gameID`) REFERENCES `game` (`gameID`)	
);


/* ITEM CREATE TABLE */

CREATE TABLE `item`(
	`itemID` INT PRIMARY KEY,
	`itemName` VARCHAR(25),
	`description` TEXT,
	`damagePoints` INT(2) NULL,
	`healthPoints` INT(2) NULL
);

/* NPC CREATE TABLE */
CREATE TABLE `npc`(
	`npcID` INT PRIMARY KEY, 
	`npcName` VARCHAR(100),
	`dialogue` TEXT,
	`itemID` INT NULL
);

/* TILE CREATE TABKE */

CREATE TABLE `tile`(
	`coordinate` DECIMAL (19,0),
	`gridID` INT,
	`npcID` INT NULL,
	`itemID` INT NULL, 
	`username` VARCHAR(50) NULL,
	`status` VARCHAR (10) NOT NULL,
	`movementTimer` TIME,
	PRIMARY KEY (`coordinate`, `gridID`),
	FOREIGN KEY (`gridID`) REFERENCES `grid` (`gridID`),
	FOREIGN KEY (`npcID`) REFERENCES `npc` (`npcID`),
	FOREIGN KEY (`itemID`) REFERENCES `item` (`itemID`),
	FOREIGN KEY (`username`) REFERENCES `character` (`username`)
);

/* INVENTORY CREATE TABLE */

CREATE TABLE `inventory`( 
	`username` VARCHAR(50),
	`itemID` INT, 
	`quantity` INT NULL,
	PRIMARY KEY (`username`, `itemID`),
	FOREIGN KEY (`username`) REFERENCES `character` (`username`),
	FOREIGN KEY (`itemID`) REFERENCES `item` (`itemID`)
);




/*INSERT USER ACCOUNTS*/

INSERT INTO user_account (`username`, `email`,`password`, `firstName`, `accountType`, `status`) VALUES ('KbyzFTW', 'kbyz@email.co.nz', 'CoolioJulio', 'Kira', 'Player', 'Active');
INSERT INTO user_account (`username`, `email`,`password`, `firstName`, `accountType`, `status`) VALUES ('DielgaChu', 'jbabs@email.co.nz', 'SwampStench', 'Julia', 'Player', 'Active');
INSERT INTO user_account (`username`, `email`,`password`, `firstName`, `accountType`, `status`) VALUES ('Fulimini', 'rossia@email.co.au', 'FKAGoth', 'Alex', 'Player', 'Active');
INSERT INTO user_account (`username`, `email`,`password`, `firstName`, `accountType`, `status`) VALUES ('Verga', 'generalmarx@email.com', 'CoconutTree', 'Mark', 'Player', 'Offline');
INSERT INTO user_account (`username`, `email`,`password`, `firstName`, `accountType`, `status`) VALUES ('VintageSistah', 'jnel@email.co.nz', 'savblanc2019', 'Junel', 'Player', 'Offline');
INSERT INTO user_account (`username`, `email`,`password`, `firstName`, `accountType`, `status`) VALUES ('KyrVorga', 'rhydawg@email.co.nz', 'somethingHard1', 'Rhylei', 'Admin', 'Offline');


/* INSERT GAME */
INSERT INTO `game` (gameID, runtime, status) VALUES (1, '10:45:23', 'Inactive');
INSERT INTO `game` (gameID, runtime, status) VALUES (2, '15:31:06', 'Inactive');
INSERT INTO `game` (gameID, runtime, status) VALUES (3, '03:07:13', 'Active');
INSERT INTO `game` (gameID, runtime, status) VALUES (4, '05:34:24', 'Active');

/*INSERT MAPS*/


INSERT INTO `map` (`mapID`, `gameID`) VALUES (4, 4);

/*INSERT GRID*/
INSERT INTO `grid` (`gridID`, `mapID`) VALUES (1, 4);
INSERT INTO `grid` (`gridID`, `mapID`) VALUES (2, 4);
INSERT INTO `grid` (`gridID`, `mapID`) VALUES (3, 4);
INSERT INTO `grid` (`gridID`, `mapID`) VALUES (4, 4);
INSERT INTO `grid` (`gridID`, `mapID`) VALUES (5, 4);
INSERT INTO `grid` (`gridID`, `mapID`) VALUES (6, 4);
INSERT INTO `grid` (`gridID`, `mapID`) VALUES (7, 4);
INSERT INTO `grid` (`gridID`, `mapID`) VALUES (8, 4);
INSERT INTO `grid` (`gridID`, `mapID`) VALUES (9, 4);

/*INSERT NPC DATA*/
INSERT INTO `npc` (`npcID`, `npcName`, `dialogue`, `itemID`) VALUES (1, 'Clyde Barrow', 'Hey partner! Im on the run and these bullets are weighing me down! Here, take some!', 1);
INSERT INTO `npc` (`npcID`, `npcName`, `dialogue`) VALUES (2, 'Wyatt Earp', 'I got my eye on you, cowpoke.');

/* INSERT ITEM DATA*/
INSERT INTO `item` (`itemID`, `itemName`, `description`, `damagePoints`) VALUES (1, 'Bullet', 'Put this in your revolver, point, and shoot.', 1);
INSERT INTO `item` (`itemID`, `itemName`, `description`, `healthPoints`) VALUES (2, 'Whiskey', 'Drink this for your vitality.', 2);


/*INSERT TILE DATA
 
Each tile is identfied by a coordinate number which matches against the foreign key of the gridID to identified where on the greater map the tile sits. 
A grid is 9x9, so each tile will be 0.0, 1.0, 2.0, 3.0 and so on to 9.0 
The data shown below is a short example. 
 */
INSERT INTO `tile` (`coordinate`, `gridID`, `npcID`, `status`, `movementTimer`) VALUES (1, 1.3, 1, 'Occupied', '00:00:15');


/* INSERT PLAYER CHARACTER DATA
 Displays two player characters at different states, offline with only relevant data, and online with current in-game data.
  */
INSERT INTO `character` (`username`, `health`, `currentScore`, `highScore`, `status`) VALUES ('KbyzFTW', 10, 2400, 5600, 'Inactive');
INSERT INTO `character` (`username`, `gameID`, `health`, `currentScore`, `highScore`, `status`, `lastAttack`, `attackCoolDown`, `invincibility`, `lastMove`, `afk`) VALUES ('KyrVorga', 4, 5, 6000, 12450, 'Active', '04:02:15', 'False', 'False', '04:01:03', 'False');



/*INSERT INVENTORY DATA*/
INSERT INTO `inventory` (`username`, `itemID`, `quantity`) VALUES ('KbyzFTW', 1, 3);
INSERT INTO `inventory` (`username`, `itemID`, `quantity`) VALUES ('KbyzFTW', 2, 0);
INSERT INTO `inventory` (`username`, `itemID`, `quantity`) VALUES ('KyrVorga', 1, 4);
INSERT INTO `inventory` (`username`, `itemID`, `quantity`) VALUES ('KyrVorga', 2, 3);




/* PROCEDURES*/

/* LOGIN ATTEMPS/CHECK */
DROP PROCEDURE IF EXISTS Login;

DELIMITER $$

CREATE PROCEDURE Login (IN `username` VARCHAR(50), IN `password` VARCHAR(100))
COMMENT 'Check login'
BEGIN
    DECLARE numAttempts INT DEFAULT 0;
    
	-- 'Check for valid login', 
    -- if valid then select message "Logged in" and reset Attempts to 0, 
    IF EXISTS (SELECT * 
                FROM user_account ua 
                WHERE 
                  username = ua.username AND
                  `password` = ua.password
                  ) 
	THEN
		UPDATE user_account ua
        SET Attempts = 0
        WHERE
           ua.username = ua.username;
           
		SELECT 'Logged In' as Message;
    
    ELSE 
    -- else add to Attempts ,
        IF EXISTS(SELECT * FROM user_account ua WHERE username = ua.username) THEN 
        
			SELECT Attempts 
			INTO numAttempts
			FROM user_account ua 
			WHERE 
			   username = ua.username;
			
			SET numAttempts = numAttempts + 1;
			
			IF numAttempts > 3 THEN 
			-- if Attempts > 5 then set lockout  to true and select message 'locked out' 
				UPDATE ua.username 
				SET LOCKED_OUT = True
				WHERE 
					 usrename = ua.username ;
					 
				 SELECT 'Locked Out' AS Message;
				 
			ELSE
			-- else select message 'Bad  password'
                 UPDATE user_account ua
                 SET Attempts = numAttempts
                 WHERE 
                    username = ua.username;
                    
				 SELECT 'Invalid user name and password';
			END IF;
      ELSE 
		SELECT 'Invalid user name and password';
      END IF;

    
    END IF;
                  
END $$
DELIMITER ;

