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
('tech_girl', 'Emily', 'Stone', 'emily@ttu.edu', 'hashed_pw2', NULL, '2023-09-15', 85),
('debugKing', 'Marcus', 'Lee', 'marcus@ttu.edu', 'hashed_pw3', '8063334444', '2023-08-21', 200),
('noobMaster', 'Kevin', 'Tran', 'kevin@ttu.edu', 'hashed_pw4', NULL, '2023-07-30', 15),
('byteWizard', 'Alice', 'Nguyen', 'alice@ttu.edu', 'hashed_pw5', '8065551111', '2023-06-10', 95),
('stackOverflowed', 'Brian', 'Clark', 'brian@ttu.edu', 'hashed_pw6', NULL, '2023-05-05', 60),
('codeNinja', 'Sofia', 'Martinez', 'sofia@ttu.edu', 'hashed_pw7', '8062223333', '2023-04-12', 180),
('logicLord', 'Daniel', 'Kim', 'daniel@ttu.edu', 'hashed_pw8', NULL, '2023-03-18', 140),
('binaryBoss', 'Chris', 'Davis', 'chris@ttu.edu', 'hashed_pw9', '8067778888', '2023-02-11', 75),
('loopMaster', 'Olivia', 'Wilson', 'olivia@ttu.edu', 'hashed_pw10', NULL, '2023-01-25', 50),
('dataDude', 'Ethan', 'Brown', 'ethan@ttu.edu', 'hashed_pw11', '8069990000', '2022-12-14', 110),
('nullPointer', 'Grace', 'Taylor', 'grace@ttu.edu', 'hashed_pw12', NULL, '2022-11-03', 30),
('syntaxError', 'Henry', 'Anderson', 'henry@ttu.edu', 'hashed_pw13', '8061212121', '2022-10-22', 65),
('compileQueen', 'Isabella', 'Thomas', 'isabella@ttu.edu', 'hashed_pw14', NULL, '2022-09-17', 155),
('aiExplorer', 'Liam', 'Jackson', 'liam@ttu.edu', 'hashed_pw15', '8063434343', '2022-08-08', 210),
('cloudCoder', 'Mia', 'White', 'mia@ttu.edu', 'hashed_pw16', NULL, '2022-07-19', 45),
('frontendFan', 'Noah', 'Harris', 'noah@ttu.edu', 'hashed_pw17', '8065656565', '2022-06-01', 70),
('backendBro', 'Ava', 'Martin', 'ava@ttu.edu', 'hashed_pw18', NULL, '2022-05-23', 95),
('fullStackPro', 'James', 'Thompson', 'james@ttu.edu', 'hashed_pw19', '8067878787', '2022-04-14', 175),
('bugHunter', 'Charlotte', 'Garcia', 'charlotte@ttu.edu', 'hashed_pw20', NULL, '2022-03-09', 130),
('devDreamer', 'Benjamin', 'Martinez', 'ben@ttu.edu', 'hashed_pw21', '8062323232', '2022-02-02', 40),
('scriptKid', 'Amelia', 'Robinson', 'amelia@ttu.edu', 'hashed_pw22', NULL, '2022-01-15', 25),
('terminalPro', 'Lucas', 'Clark', 'lucas@ttu.edu', 'hashed_pw23', '8064545454', '2021-12-11', 160),
('gitGud', 'Harper', 'Rodriguez', 'harper@ttu.edu', 'hashed_pw24', NULL, '2021-11-05', 90),
('kernelPanic', 'Elijah', 'Lewis', 'elijah@ttu.edu', 'hashed_pw25', '8066767676', '2021-10-01', 220);

-- SUBREDDITS
INSERT INTO SUBREDDIT (subreddit_name, description, creation_date) VALUES
('TTU_CS', 'Texas Tech Computer Science discussions', '2022-05-10 14:30:00'),
('ProgrammingHelp', 'Help with coding problems and debugging', '2024-05-10 14:30:00'),
('RedRaiderSports', 'All about TTU sports and game discussions', '2023-05-10 14:30:00'),
('DataScienceHub', 'Discussions on data science, ML, and AI', '2023-02-18 10:15:00'),
('WebDevWorld', 'Frontend and backend web development topics', '2022-11-05 09:00:00'),
('JavaNation', 'Everything Java programming related', '2021-09-21 16:45:00'),
('CPlusPlusCorner', 'C++ programming and system design talk', '2022-03-12 13:20:00'),
('AI_Research', 'Artificial intelligence research and breakthroughs', '2024-01-08 08:30:00'),
('CyberSecurityTalk', 'Security news, tools, and ethical hacking', '2023-07-19 12:00:00'),
('StudentLifeTTU', 'Life, tips, and experiences at Texas Tech University', '2021-10-30 18:10:00');

-- POSTS
INSERT INTO POST (title, p_created_at, score, subreddit_name, user_id) VALUES
('How to learn SQL fast?', '2024-03-10 10:15:00', 10, 'ProgrammingHelp', 1),
('Best study spots on campus?', '2023-09-12 14:20:00', 5, 'TTU_CS', 2),
('Game day hype!', '2023-10-01 18:30:00', 20, 'RedRaiderSports', 3),
('Difference between JOIN and UNION?', '2024-01-22 09:00:00', 12, 'ProgrammingHelp', 2),
('Jacob Rodriguez to the Dolphins!', '2024-02-15 12:00:00', 1100, 'RedRaiderSports', 4),
('Debugging tips for beginners', '2023-06-05 11:45:00', 35, 'ProgrammingHelp', 5),
('What is recursion really?', '2023-07-19 16:10:00', 42, 'TTU_CS', 6),
('Best coding languages in 2025?', '2024-04-02 08:30:00', 88, 'ProgrammingHelp', 7),
('AI replacing programmers?', '2024-03-28 13:25:00', 120, 'AI_Research', 8),
('Cybersecurity basics for students', '2023-11-11 09:40:00', 60, 'CyberSecurityTalk', 9),
('Java vs Python for beginners', '2022-08-14 15:00:00', 75, 'JavaNation', 10),
('C++ memory management explained', '2022-09-21 10:05:00', 90, 'CPlusPlusCorner', 11),
('Frontend roadmap 2024', '2024-01-10 17:45:00', 130, 'WebDevWorld', 12),
('Backend vs Full stack careers', '2023-05-18 12:10:00', 55, 'WebDevWorld', 13),
('Machine learning projects ideas', '2024-02-01 14:00:00', 160, 'DataScienceHub', 14),
('Campus WiFi is terrible', '2022-10-03 09:25:00', 18, 'StudentLifeTTU', 15),
('Best professors in CS department', '2023-03-14 11:30:00', 40, 'TTU_CS', 16),
('How to survive finals week', '2021-12-09 19:00:00', 200, 'StudentLifeTTU', 17),
('Linux vs Windows for dev work', '2023-08-08 10:20:00', 95, 'ProgrammingHelp', 18),
('Is AI coding cheating?', '2024-04-15 13:15:00', 150, 'AI_Research', 19),
('Top 10 coding interview questions', '2023-01-25 08:00:00', 110, 'ProgrammingHelp', 20),
('Best laptops for CS students', '2022-11-30 14:50:00', 70, 'TTU_CS', 21),
('Python tricks you should know', '2024-03-05 16:40:00', 180, 'ProgrammingHelp', 22),
('Big 12 predictions this season', '2023-09-01 12:00:00', 300, 'RedRaiderSports', 23),
('Debugging segmentation faults', '2022-12-12 10:10:00', 65, 'CPlusPlusCorner', 24),
('How do you add content to your post?', '2023-09-01 12:00:00', 4, 'TTU_CS', 1);

-- COMMENTS
INSERT INTO COMMENT (comment_num, post_id, user_id, text, c_created_at) VALUES
(1, 1, 2, 'Practice joins and queries daily.', '2024-03-10 10:20:00'),
(2, 1, 3, 'Build projects, that helps a lot.', '2024-03-10 10:25:00'),
(3, 1, 4, 'Don’t just watch tutorials—code along.', '2024-03-10 10:30:00'),
(1, 2, 1, 'Library 3rd floor is quiet.', '2023-09-12 14:30:00'),
(2, 2, 5, 'Try the engineering building too.', '2023-09-12 14:35:00'),
(1, 3, 6, 'Let’s go Raiders!', '2023-10-01 18:35:00'),
(2, 3, 7, 'This season is going to be insane.', '2023-10-01 18:40:00'),
(1, 4, 8, 'JOIN vs UNION confuses everyone at first.', '2024-01-22 09:10:00'),
(2, 4, 9, 'Think of UNION as stacking results.', '2024-01-22 09:12:00'),
(3, 4, 10, 'JOIN connects related rows.', '2024-01-22 09:15:00'),
(1, 5, 11, 'Huge W for Texas Tech football!', '2024-02-15 12:05:00'),
(2, 5, 12, 'Did not expect that trade honestly.', '2024-02-15 12:10:00'),
(1, 6, 13, 'Start with small bugs first.', '2023-06-05 11:50:00'),
(2, 6, 14, 'Debugging is 80% reading logs.', '2023-06-05 11:55:00'),
(1, 7, 15, 'Recursion is just function calling itself.', '2023-07-19 16:15:00'),
(2, 7, 16, 'Base case is everything.', '2023-07-19 16:18:00'),
(1, 8, 17, 'Python is still top tier imo.', '2024-04-02 08:35:00'),
(2, 8, 18, 'Java is better for structure though.', '2024-04-02 08:40:00'),
(1, 9, 19, 'AI won’t replace devs, just tools.', '2024-03-28 13:30:00'),
(2, 9, 20, 'It will change the workflow though.', '2024-03-28 13:35:00'),
(1, 10, 21, 'Use VPN and MFA for security.', '2023-11-11 09:45:00'),
(2, 10, 22, 'Don’t reuse passwords ever.', '2023-11-11 09:50:00'),
(1, 11, 23, 'Java is verbose but powerful.', '2022-08-14 15:05:00'),
(2, 11, 24, 'Python is easier for beginners.', '2022-08-14 15:10:00'),
(1, 12, 1, 'Pointers are the hardest part of C++.', '2022-09-21 10:10:00'),
(2, 12, 2, 'Memory management takes practice.', '2022-09-21 10:15:00'),
(1, 13, 3, 'Frontend is more design heavy.', '2024-01-10 17:50:00'),
(2, 13, 4, 'Backend is logic heavy.', '2024-01-10 17:55:00'),
(1, 14, 5, 'Full stack gives best flexibility.', '2023-05-18 12:15:00'),
(2, 14, 6, 'Pick what you enjoy more.', '2023-05-18 12:20:00'),
(5, 2, 3, 'Wow you !@?! can''t code?', '2024-04-28 16:07:00');

-- MESSAGES
INSERT INTO MESSAGE (sender_id, receiver_id, content, sent_time) VALUES

(1, 2, 'Hey, do you understand SQL joins?', '2024-03-10 09:00:00'),
(2, 1, 'Yeah, I can help you with that!', '2024-03-10 09:05:00'),
(1, 3, 'Can you review my project?', '2024-03-10 09:10:00'),
(3, 1, 'Sure, send it over.', '2024-03-10 09:15:00'),
(4, 1, 'Are you going to the game?', '2024-03-10 09:20:00'),
(5, 6, 'How is the CS class this semester?', '2023-09-12 13:00:00'),
(6, 5, 'It’s tough but manageable.', '2023-09-12 13:10:00'),
(7, 8, 'Did you finish the assignment?', '2023-09-12 13:20:00'),
(8, 7, 'Not yet, working on it.', '2023-09-12 13:25:00'),
(9, 10, 'Need help debugging C++ code.', '2023-09-12 13:30:00'),
(10, 9, 'Send it, I’ll take a look.', '2023-09-12 13:35:00'),
(11, 12, 'What languages are you learning?', '2023-05-18 18:00:00'),
(12, 11, 'Mostly Java and Python.', '2023-05-18 18:05:00'),
(13, 14, 'Are you joining the hackathon?', '2023-05-18 18:10:00'),
(14, 13, 'Yes, team is ready.', '2023-05-18 18:15:00'),
(15, 16, 'How’s campus life?', '2022-10-03 11:00:00'),
(16, 15, 'Pretty busy but fun.', '2022-10-03 11:10:00'),
(17, 18, 'Got any study tips?', '2022-10-03 11:20:00'),
(18, 17, 'Practice daily coding problems.', '2022-10-03 11:25:00'),
(19, 20, 'What’s your GPA goal?', '2022-10-03 11:30:00'),
(20, 19, 'Trying for 3.8+', '2022-10-03 11:35:00'),
(21, 22, 'Did you pass the exam?', '2022-03-14 10:00:00'),
(22, 21, 'Barely, but yes!', '2022-03-14 10:05:00'),
(23, 24, 'Need help with recursion.', '2021-12-09 15:00:00'),
(24, 23, 'Start with base cases first.', '2021-12-09 15:05:00');

-- CONTENT
INSERT INTO CONTENT (post_id, caption, file_size, url) VALUES

(1, 'SQL joins diagram', 1.20, 'https://techit.com/media/sql_joins.png'),
(2, 'Quiet study area map', 2.50, 'https://techit.com/media/study_spots.jpg'),
(3, 'Game day crowd video', 15.80, 'https://techit.com/media/gameday.mp4'),
(4, 'JOIN vs UNION visual explanation', 1.75, 'https://techit.com/media/join_union.png'),
(5, 'Football trade highlight clip', 20.00, 'https://techit.com/media/trade.mp4'),
(6, 'Debugging workflow chart', 1.10, 'https://techit.com/media/debugging.png'),
(7, 'Recursion call stack diagram', 1.60, 'https://techit.com/media/recursion.png'),
(8, 'Top programming languages ranking', 2.00, 'https://techit.com/media/languages.jpg'),
(9, 'AI model architecture overview', 3.40, 'https://techit.com/media/ai_model.png'),
(10, 'Cybersecurity checklist', 1.25, 'https://techit.com/media/security.png'),
(11, 'Java vs Python comparison', 2.10, 'https://techit.com/media/java_python.png'),
(12, 'C++ memory layout diagram', 1.90, 'https://techit.com/media/cpp_memory.png'),
(13, 'Frontend roadmap image', 2.60, 'https://techit.com/media/frontend_roadmap.jpg'),
(14, 'Backend architecture diagram', 2.80, 'https://techit.com/media/backend.png'),
(15, 'Machine learning project ideas list', 1.50, 'https://techit.com/media/ml_projects.png'),
(16, 'Campus WiFi speed test result', 1.00, 'https://techit.com/media/wifi.png'),
(17, 'CS department building photo', 3.10, 'https://techit.com/media/cs_building.jpg'),
(18, 'Finals week survival tips sheet', 1.30, 'https://techit.com/media/finals_tips.png'),
(19, 'Linux terminal commands cheat sheet', 1.40, 'https://techit.com/media/linux_cheatsheet.png'),
(20, 'AI impact infographic', 2.20, 'https://techit.com/media/ai_impact.png'),
(21, 'Coding interview prep guide', 1.80, 'https://techit.com/media/interview.png'),
(22, 'Laptop comparison table', 2.30, 'https://techit.com/media/laptops.jpg'),
(23, 'Python tricks cheat sheet', 1.35, 'https://techit.com/media/python_tricks.png'),
(24, 'Football stats breakdown', 2.90, 'https://techit.com/media/football_stats.png'),
(25, 'Segmentation fault explanation diagram', 1.55, 'https://techit.com/media/segfault.png');

-- IMAGE
INSERT INTO IMAGE (content_id, format) VALUES

(1, 'PNG'),
(2, 'JPG'),
(4, 'PNG'),
(6, 'JPG'),
(7, 'PNG'),
(8, 'JPEG'),
(10, 'PNG'),
(11, 'JPG'),
(13, 'PNG'),
(15, 'JPEG'),
(16, 'PNG'),
(17, 'JPG'),
(18, 'PNG'),
(19, 'JPEG'),
(21, 'PNG'),
(22, 'JPG'),
(23, 'PNG'),
(25, 'JPEG'),
(9, 'PNG'),
(12, 'JPG'),
(14, 'PNG'),
(20, 'JPEG'),
(3, 'JPG'),
(5, 'PNG'),
(24, 'JPEG');

-- VIDEO
INSERT INTO VIDEO (content_id, duration) VALUES

(3, 120),
(5, 95),
(9, 240),
(12, 180),
(14, 210),
(18, 75),
(20, 300),
(24, 150),
(1, 60),
(2, 45),
(4, 110),
(6, 200),
(7, 160),
(8, 90),
(10, 130),
(11, 140),
(13, 220),
(15, 175),
(16, 80),
(17, 260),
(19, 100),
(21, 190),
(22, 230),
(23, 85),
(25, 170);

-- VOTES
INSERT INTO VOTES_ON (user_id, post_id, vote_type, vote_time) VALUES

(1, 2, 'up', '2024-03-10 09:05:00'),
(2, 1, 'up', '2024-03-10 09:06:00'),
(3, 1, 'up', '2024-03-10 09:07:00'),
(4, 1, 'down', '2024-03-10 09:08:00'),
(5, 3, 'up', '2024-03-10 09:09:00'),
(6, 3, 'up', '2023-09-12 13:05:00'),
(7, 3, 'up', '2023-09-12 13:06:00'),
(8, 4, 'up', '2024-01-22 09:10:00'),
(9, 4, 'down', '2024-01-22 09:11:00'),
(10, 4, 'up', '2024-01-22 09:12:00'),
(11, 5, 'up', '2024-02-15 12:01:00'),
(12, 5, 'up', '2024-02-15 12:02:00'),
(13, 6, 'up', '2023-06-05 11:51:00'),
(14, 6, 'down', '2023-06-05 11:52:00'),
(15, 7, 'up', '2023-07-19 16:16:00'),
(16, 7, 'up', '2023-07-19 16:17:00'),
(17, 8, 'up', '2024-04-02 08:31:00'),
(18, 8, 'up', '2024-04-02 08:32:00'),
(19, 9, 'up', '2024-03-28 13:31:00'),
(20, 9, 'down', '2024-03-28 13:32:00'),
(21, 10, 'up', '2023-11-11 09:41:00'),
(22, 10, 'up', '2023-11-11 09:42:00'),
(23, 11, 'up', '2022-08-14 15:06:00'),
(24, 11, 'down', '2022-08-14 15:07:00'),
(1, 11, 'up', '2022-08-14 15:08:00'),
(2, 12, 'up', '2022-09-21 10:11:00'),
(3, 12, 'up', '2022-09-21 10:12:00'),
(4, 13, 'up', '2024-01-10 17:51:00'),
(5, 13, 'up', '2024-01-10 17:52:00'),
(6, 14, 'up', '2023-05-18 12:16:00'),
(7, 14, 'down', '2023-05-18 12:17:00'),
(8, 15, 'up', '2024-02-01 14:01:00'),
(9, 15, 'up', '2024-02-01 14:02:00'),
(10, 16, 'up', '2022-10-03 09:26:00'),
(11, 16, 'down', '2022-10-03 09:27:00'),
(12, 17, 'up', '2023-03-14 11:31:00'),
(13, 17, 'up', '2023-03-14 11:32:00'),
(14, 18, 'up', '2021-12-09 19:01:00'),
(15, 18, 'up', '2021-12-09 19:02:00'),
(16, 19, 'up', '2023-08-08 10:21:00'),
(17, 19, 'down', '2023-08-08 10:22:00'),
(18, 20, 'up', '2024-04-15 13:16:00'),
(19, 20, 'up', '2024-04-15 13:17:00'),
(20, 21, 'up', '2023-01-25 08:01:00'),
(21, 21, 'up', '2023-01-25 08:02:00');

-- MODERATORS
INSERT INTO MODERATES (user_id, subreddit_name) VALUES

(1, 'TTU_CS'),
(2, 'TTU_CS'),
(3, 'ProgrammingHelp'),
(4, 'RedRaiderSports'),
(5, 'ProgrammingHelp'),
(6, 'DataScienceHub'),
(7, 'WebDevWorld'),
(8, 'AI_Research'),
(9, 'CyberSecurityTalk'),
(10, 'JavaNation'),
(11, 'CPlusPlusCorner'),
(12, 'WebDevWorld'),
(13, 'ProgrammingHelp'),
(14, 'DataScienceHub'),
(15, 'StudentLifeTTU'),
(16, 'TTU_CS'),
(17, 'StudentLifeTTU'),
(18, 'ProgrammingHelp'),
(19, 'AI_Research'),
(20, 'CyberSecurityTalk'),
(21, 'TTU_CS'),
(22, 'ProgrammingHelp'),
(23, 'RedRaiderSports'),
(24, 'CPlusPlusCorner'),
(25, 'WebDevWorld');

-- TAGS
INSERT INTO TAGS (post_id, tag) VALUES

(1, 'SQL'),
(1, 'database'),
(2, 'campus'),
(2, 'study'),
(3, 'sports'),
(3, 'football'),
(4, 'SQL'),
(4, 'JOIN'),
(4, 'UNION'),
(5, 'football'),
(5, 'NFL'),
(6, 'debugging'),
(6, 'beginners'),
(7, 'recursion'),
(7, 'C++'),
(8, 'programming'),
(8, 'career'),
(9, 'AI'),
(9, 'machine-learning'),
(10, 'cybersecurity'),
(10, 'security'),
(11, 'Java'),
(11, 'Python'),
(12, 'C++'),
(12, 'memory'),
(13, 'frontend'),
(13, 'web-dev'),
(14, 'backend'),
(14, 'architecture'),
(15, 'ML'),
(15, 'projects');

-- VIEWS

DROP VIEW IF EXISTS ContentStream;
DROP VIEW IF EXISTS TTU_CS_POSTS;
DROP VIEW IF EXISTS TTU_PROG_POSTS;
DROP VIEW IF EXISTS Admin_Mod;
DROP VIEW IF EXISTS Admin_Comment_Mod;
DROP VIEW IF EXISTS TTU_SPORTS_POSTS;
DROP VIEW IF EXISTS Admin_Post_Mod;
DROP VIEW IF EXISTS Admin_Message_Mod;

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

CREATE VIEW Admin_Message_Mod AS
SELECT
    u.user_id,
    u.email,
    m.message_id,
    m.content,
    m.sent_time,
    m.receiver_id
FROM USERS u
JOIN MESSAGE m ON u.user_id = m.sender_id;

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

-- User (Student) Main Feed
CREATE VIEW USER_POST_FEED AS
Select 
*
FROM TTU_CS_POSTS
UNION ALL
Select 
*
FROM TTU_PROG_POSTS
UNION ALL
Select 
*
FROM TTU_SPORTS_POSTS;
-- QUERIES from my views
Select * from TTU_CS_POSTS;
Select * from TTU_PROG_POSTS;
Select * from TTU_SPORTS_POSTS;
Select post_id, title from POST;
Select * from Admin_Mod order by post_id;
Select * from ContentStream;
Select * from USER_POST_FEED;

-- QUERIES
-- _____________________________________________

-- Total score across all posts
Select username, sum(score) as total_score FROM POST p left join USERS u on p.user_id = u.user_id group by p.user_id;

-- Moderaters of Subreddits
Select CONCAT(f_name, " ", l_name) as Name, subreddit_name FROM Moderates m join USERS u where m.user_id = u.user_id;

-- Top Post(s) across TechIt
Select post_id, title, score From POST where score = (Select max(score) from POST);

-- UPDATES
UPDATE USERS SET username = 'TeaDog' where username = 'noobMaster';

-- Finding comments with explicatives (using LIKE())
SELECT comment_num, text FROM comment where text LIKE '%!@?!%';

-- join
SELECT u.username, p.title
FROM USERS u
JOIN POST p ON u.user_id = p.user_id;

-- aggregate
SELECT s.subreddit_name,
       COUNT(p.post_id) AS total_posts,
       AVG(p.score) AS avg_score
FROM SUBREDDIT s
JOIN POST p ON s.subreddit_name = p.subreddit_name
GROUP BY s.subreddit_name;

-- Having
SELECT s.subreddit_name,
       COUNT(p.post_id) AS total_posts
FROM SUBREDDIT s
JOIN POST p ON s.subreddit_name = p.subreddit_name
GROUP BY s.subreddit_name
HAVING COUNT(p.post_id) >= 5;

-- nested
SELECT post_id, title, score
FROM POST
WHERE score > (SELECT AVG(score) FROM POST);

-- Posts from a certain user (tech_girl)
Select post_id, title
FROM Post
Where user_id = 
(SELECT user_id 
FROM USERS
WHERE username = 'tech_girl');
-- Posts with multiple tags
SELECT p.post_id, p.title, group_concat(t.tag) as tags
FROM POST p NATURAL JOIN TAGS t
GROUP BY p.post_id
HAVING count(t.tag) > 1;

-- moderation
SELECT c.comment_num, c.text, p.title, u.username
FROM COMMENT c
JOIN POST p ON c.post_id = p.post_id
JOIN USERS u ON c.user_id = u.user_id;

-- Shows all subreddits (including empty ones), sorted by activity
SELECT s.subreddit_name,
       COUNT(p.post_id) AS total_posts
FROM SUBREDDIT s
LEFT JOIN POST p ON s.subreddit_name = p.subreddit_name
GROUP BY s.subreddit_name
ORDER BY total_posts DESC
LIMIT 5;

-- Shows unique users who have posted, filtered by karma
SELECT DISTINCT u.username, u.karma
FROM USERS u
JOIN POST p ON u.user_id = p.user_id
WHERE u.karma > 100
ORDER BY u.karma DESC;

-- Shows posts with or without comments, prioritizing highest score
SELECT p.post_id, p.title, p.score, c.text
FROM POST p
LEFT JOIN COMMENT c ON p.post_id = c.post_id
WHERE p.score > 50
ORDER BY p.score DESC
LIMIT 10;

-- Shows posts with their content, only posts with content in this scenario
Select p.post_id, p.title, c.caption, c.url
FROM post p
JOIN content c on p.post_id = c.post_id;

-- Show posts and any content they have included even if content is null
Select p.post_id, p.title, c.caption, c.url
From post p left join content c on p.post_id = c.post_id;

-- DELETIONS (Only run if testing functionality)
DELETE FROM post WHERE post_id = 1;

