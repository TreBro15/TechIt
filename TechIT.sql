-- TechIt Database - Schema + Fake Data
CREATE DATABASE IF NOT EXISTS TechIt;
USE TechIt;
-- Drop tables for rerun
DROP TABLE IF EXISTS TAGS;
DROP TABLE IF EXISTS MODERATES;
DROP TABLE IF EXISTS VOTES_ON;
DROP TABLE IF EXISTS IMAGE;
DROP TABLE IF EXISTS VIDEO;
DROP TABLE IF EXISTS CONTENT;
DROP TABLE IF EXISTS MESSAGE;
DROP TABLE IF EXISTS COMMENT;
DROP TABLE IF EXISTS POST;
DROP TABLE IF EXISTS SUBREDDIT;
DROP TABLE IF EXISTS USERS;

-- USERS
-- -------------------------------
CREATE TABLE USERS (
    user_id INT UNSIGNED AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    f_name VARCHAR(50) NOT NULL,
    l_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    phone_num VARCHAR(15),
    join_date DATE NOT NULL,
    karma INT NOT NULL DEFAULT 0,
    PRIMARY KEY (user_id)
);

-- SUBREDDIT
-- -------------------------------
CREATE TABLE SUBREDDIT (
    subreddit_name VARCHAR(100) NOT NULL,
    description TEXT,
    creation_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (subreddit_name)
);

-- POST
-- -------------------------------
CREATE TABLE POST (
    post_id INT UNSIGNED AUTO_INCREMENT,
    title VARCHAR(300) NOT NULL,
    p_created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    score INT NOT NULL DEFAULT 0,
    subreddit_name VARCHAR(100) NOT NULL,
    user_id INT UNSIGNED NOT NULL,
    PRIMARY KEY (post_id),
    FOREIGN KEY (subreddit_name) REFERENCES SUBREDDIT(subreddit_name),
    FOREIGN KEY (user_id) REFERENCES USERS(user_id)
);

-- COMMENT
-- -------------------------------
CREATE TABLE COMMENT (
    comment_num INT UNSIGNED,
    post_id INT UNSIGNED,
    user_id INT UNSIGNED NOT NULL,
    text TEXT NOT NULL,
    c_created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (comment_num, post_id),
    FOREIGN KEY (post_id) REFERENCES POST(post_id),
    FOREIGN KEY (user_id) REFERENCES USERS(user_id)
);

-- MESSAGE
-- -------------------------------
CREATE TABLE MESSAGE (
    message_id INT UNSIGNED AUTO_INCREMENT,
    sender_id INT UNSIGNED NOT NULL,
    receiver_id INT UNSIGNED NOT NULL,
    content TEXT NOT NULL,
    sent_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (message_id),
    FOREIGN KEY (sender_id) REFERENCES USERS(user_id),
    FOREIGN KEY (receiver_id) REFERENCES USERS(user_id)
);

-- CONTENT
-- -------------------------------
CREATE TABLE CONTENT (
    content_id INT UNSIGNED AUTO_INCREMENT,
    post_id INT UNSIGNED NOT NULL,
    caption VARCHAR(500),
    file_size DECIMAL(10,2) NOT NULL,
    url VARCHAR(2048) NOT NULL,
    PRIMARY KEY (content_id),
    FOREIGN KEY (post_id) REFERENCES POST(post_id)
);

-- VIDEO
-- -------------------------------
CREATE TABLE VIDEO (
    content_id INT UNSIGNED,
    duration INT NOT NULL,
    PRIMARY KEY (content_id),
    FOREIGN KEY (content_id) REFERENCES CONTENT(content_id)
);

-- IMAGE
-- -------------------------------
CREATE TABLE IMAGE (
    content_id INT UNSIGNED,
    format VARCHAR(10) NOT NULL,
    PRIMARY KEY (content_id),
    FOREIGN KEY (content_id) REFERENCES CONTENT(content_id)
);

-- VOTES_ON
-- -------------------------------
CREATE TABLE VOTES_ON (
    user_id INT UNSIGNED,
    post_id INT UNSIGNED,
    vote_type ENUM('up','down') NOT NULL,
    vote_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, post_id),
    FOREIGN KEY (user_id) REFERENCES USERS(user_id),
    FOREIGN KEY (post_id) REFERENCES POST(post_id)
);

-- MODERATES
-- -------------------------------
CREATE TABLE MODERATES (
    user_id INT UNSIGNED,
    subreddit_name VARCHAR(100),
    PRIMARY KEY (user_id, subreddit_name),
    FOREIGN KEY (user_id) REFERENCES USERS(user_id),
    FOREIGN KEY (subreddit_name) REFERENCES SUBREDDIT(subreddit_name)
);

-- TAGS
-- -------------------------------
CREATE TABLE TAGS (
    post_id INT UNSIGNED,
    tag VARCHAR(100),
    PRIMARY KEY (post_id, tag),
    FOREIGN KEY (post_id) REFERENCES POST(post_id)
);

-- INSERT DATA
-- -------------------------------

-- USERS
INSERT INTO USERS (username, f_name, l_name, email, password, phone_num, join_date, karma) VALUES
('coderJay', 'Jaycob', 'Arsenal', 'jaycob@ttu.edu', 'hashed_pw1', '8061112222', '2023-10-08', 120),
('tech_girl', 'Emily', 'Stone', 'emily@ttu.edu', 'hashed_pw2', NULL, '2023-10-08', 85),
('debugKing', 'Marcus', 'Lee', 'marcus@ttu.edu', 'hashed_pw3', '8063334444', '2023-10-08', 200),
('noobMaster', 'Kevin', 'Tran', 'kevin@ttu.edu', 'hashed_pw4', NULL,'2023-10-08',  15);

-- SUBREDDITS
INSERT INTO SUBREDDIT (subreddit_name, description, creation_date) VALUES
('TTU_CS', 'Texas Tech Computer Science discussions', '2022-05-10 14:30:00'),
('ProgrammingHelp', 'Help with coding problems', '2024-05-10 14:30:00'),
('RedRaiderSports', 'All about TTU sports', '2023-05-10 14:30:00');

-- POSTS
INSERT INTO POST (title, subreddit_name, user_id, score) VALUES
('How to learn SQL fast?', 'ProgrammingHelp', 1, 10),
('Best study spots on campus?', 'TTU_CS', 2, 5),
('Game day hype!', 'RedRaiderSports', 3, 20),
('Difference between JOIN and UNION?', 'ProgrammingHelp', 2, 12),
('Jacob Rodriguez to the Dolphins!', 'RedRaiderSports', 4, 1100);

-- COMMENTS
INSERT INTO COMMENT (comment_num, post_id, user_id, text) VALUES
(1, 1, 2, 'Practice joins and queries daily.'),
(2, 1, 3, 'Build projects, that helps a lot.'),
(1, 2, 1, 'Library 3rd floor is quiet.');

-- MESSAGES
INSERT INTO MESSAGE (sender_id, receiver_id, content) VALUES
(1, 2, 'Hey, need help with SQL?'),
(2, 1, 'Yes please!'),
(3, 4, 'Wanna be friends?'),
(4, 3, 'No you''re weird');

-- CONTENT
INSERT INTO CONTENT (post_id, caption, file_size, url) VALUES
(1, 'SQL diagram', 1.25, 'http://example.com/sql.png'),
(3, 'Game highlight video', 15.50, 'http://example.com/video.mp4');

-- IMAGE
INSERT INTO IMAGE (content_id, format) VALUES
(1, 'PNG');

-- VIDEO
INSERT INTO VIDEO (content_id, duration) VALUES
(2, 120);

-- VOTES
INSERT INTO VOTES_ON (user_id, post_id, vote_type) VALUES
(2, 1, 'up'),
(3, 1, 'up'),
(4, 2, 'down');

-- MODERATORS
INSERT INTO MODERATES (user_id, subreddit_name) VALUES
(1, 'ProgrammingHelp'),
(3, 'RedRaiderSports');

-- TAGS
INSERT INTO TAGS (post_id, tag) VALUES
(1, 'SQL'),
(1, 'database'),
(2, 'campus'),
(3, 'sports');

-- VIEWS
-- All Posts from TTU_CS Subreddit
CREATE VIEW TTU_CS_POSTS AS
SELECT 
    s.subreddit_name,
    s.description,
    s.creation_date,
    p.post_id,
    p.title,
    p.p_created_at,
    p.score,
    p.user_id,
    c.comment_num,
    c.text
FROM SUBREDDIT s
JOIN POST p ON s.subreddit_name = p.subreddit_name
left JOIN COMMENT c on c.post_id = p.post_id
WHERE s.subreddit_name = 'TTU_CS';
-- All Posts from ProgrammingHelp Subreddit
CREATE VIEW TTU_PROG_POSTS AS
SELECT 
    s.subreddit_name,
    s.description,
    s.creation_date,
    p.post_id,
    p.title,
    p.p_created_at,
    p.score,
    p.user_id,
    c.comment_num,
    c.text
FROM SUBREDDIT s
JOIN POST p ON s.subreddit_name = p.subreddit_name
left JOIN COMMENT c on c.post_id = p.post_id
WHERE s.subreddit_name = 'ProgrammingHelp';
-- All Posts from RedRaiderSports Subreddit
DROP VIEW TTU_SPORTS_POSTS;
CREATE VIEW TTU_SPORTS_POSTS AS
SELECT 
    s.subreddit_name,
    s.description,
    s.creation_date,
    p.post_id,
    p.title,
    p.p_created_at,
    p.score,
    p.user_id,
    c.comment_num,
    c.text
FROM SUBREDDIT s
JOIN POST p ON s.subreddit_name = p.subreddit_name
left JOIN COMMENT c on c.post_id = p.post_id
WHERE s.subreddit_name = 'RedRaiderSports';
-- All Posts for admins to moderate over
CREATE VIEW Admin_Post_Mod AS
SELECT
    u.user_id,
    u.email,
    p.post_id,
    p.title
FROM USERS u
JOIN POST p ON u.user_id = p.user_id;
-- All Comments for admins to moderate over
CREATE VIEW Admin_Comment_Mod AS
SELECT
    u.user_id,
    u.email,
    p.post_id,
    p.title,
    c.comment_num,
    c.text
FROM USERS u
JOIN POST p ON u.user_id = p.user_id
JOIN COMMENT c ON p.post_id = c.post_id;
-- Everything for admins to moderate over
CREATE VIEW Admin_Mod AS
SELECT 
    user_id, 
    email, 
    post_id, 
    title, 
    NULL AS comment_num, 
    NULL AS text, 
    NULL AS message_id, 
    NULL AS message_content
FROM Admin_Post_Mod
UNION
SELECT 
    user_id, 
    email, 
    post_id, 
    title, 
    comment_num, 
    text, 
    NULL, 
    NULL
FROM Admin_Comment_Mod
UNION
SELECT 
    user_id, 
    email, 
    NULL, 
    NULL, 
    NULL, 
    NULL, 
    message_id, 
    content
FROM Admin_Message_Mod;

-- All content that needs to be screened by admins
CREATE VIEW ContentStream AS
Select * From CONTENT;
-- QUERIES from my view
Select * from TTU_CS_POSTS;
Select * from TTU_PROG_POSTS;
Select * from TTU_SPORTS_POSTS;
Select post_id, title from POST;
Select * from Admin_Mod order by post_id;
Select * from ContentStream;
-- Total score across all posts
Select username, sum(score) as total_score FROM POST p left join USERS u on p.user_id = u.user_id group by p.user_id;

-- Moderaters of Subreddits
Select CONCAT(f_name, " ", l_name) as Name, subreddit_name FROM Moderates m join USERS u where m.user_id = u.user_id;

-- Top Post(s) across TechIt
Select post_id, title, score From POST where score = (Select max(score) from POST);

-- UPDATES
UPDATE USERS SET username = 'TeaDog' where username = 'noobMaster';
