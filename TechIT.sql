-- TechIt Database - Schema + Fake Data

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
DROP TABLE IF EXISTS USER;

-- USER
-- -------------------------------
CREATE TABLE USER (
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
    FOREIGN KEY (user_id) REFERENCES USER(user_id)
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
    FOREIGN KEY (user_id) REFERENCES USER(user_id)
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
    FOREIGN KEY (sender_id) REFERENCES USER(user_id),
    FOREIGN KEY (receiver_id) REFERENCES USER(user_id)
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
    FOREIGN KEY (user_id) REFERENCES USER(user_id),
    FOREIGN KEY (post_id) REFERENCES POST(post_id)
);

-- MODERATES
-- -------------------------------
CREATE TABLE MODERATES (
    user_id INT UNSIGNED,
    subreddit_name VARCHAR(100),
    PRIMARY KEY (user_id, subreddit_name),
    FOREIGN KEY (user_id) REFERENCES USER(user_id),
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
INSERT INTO USER (username, f_name, l_name, email, password, phone_num, join_date, karma) VALUES
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
('Game day hype!', 'RedRaiderSports', 3, 20);

-- COMMENTS
INSERT INTO COMMENT (comment_num, post_id, user_id, text) VALUES
(1, 1, 2, 'Practice joins and queries daily.'),
(2, 1, 3, 'Build projects, that helps a lot.'),
(1, 2, 1, 'Library 3rd floor is quiet.');

-- MESSAGES
INSERT INTO MESSAGE (sender_id, receiver_id, content) VALUES
(1, 2, 'Hey, need help with SQL?'),
(2, 1, 'Yes please!');

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