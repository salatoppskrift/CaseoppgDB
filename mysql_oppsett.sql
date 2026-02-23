create database regainhonour;
use regainhonour;

CREATE TABLE Courses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    courseName TEXT NOT NULL
);

CREATE TABLE Students (
    studentId VARCHAR(15) PRIMARY KEY NOT NULL,  -- ALT: 'studentId TEXT PRIMARY KEY NOT NULL' gav **Error!** MySQL (strictmode) godtok IKKE at en teskt-primary key skulle ikke ha en FAST BESTEMT LENGDE
    eventType INT,
    name TEXT NOT NULL,
    FOREIGN KEY(eventType) REFERENCES Courses(id)
);

CREATE TABLE Events (
    eventId VARCHAR(15) PRIMARY KEY NOT NULL, -- Same deal som i Students, IKKE LOV m ubestemt lengde på en tekstprimærnøkkel!
    studentId VARCHAR(15),
    courseId INT,
    FOREIGN KEY(studentId) REFERENCES Students(studentId),
    FOREIGN KEY(courseId) REFERENCES courses(id)
);

INSERT INTO courses (courseName) VALUES ("Start IT"), ("Intro"), ("FrontEnd"), ("BackEnd"), ("GET Prepared"), ("GET IT");
INSERT INTO students VALUES ("c87b943a-66f8-4", 2, "Demogoroth Satanum");
INSERT INTO events VALUES ("43a-66f8-42e8-9", "c87b943a-66f8-4", 2);

DELETE FROM events;
INSERT INTO events VALUES ("43a-66f8-42e8-9", "c87b943a-66f8-4", 2);

DELETE FROM events WHERE eventId = "43a-66f8-42e8-9";

CREATE TABLE Events_2 (
    eventId VARCHAR(15) PRIMARY KEY NOT NULL,
    studentId VARCHAR(15),
    courseId INT,
    FOREIGN KEY(studentId) REFERENCES Students(studentId) ON DELETE CASCADE
    -- altså, Events_2 kan ikke bli lagt til en rad før etter Students har fått en rad (det samme gjelder den originale Events), men m ON DELETE CASCADE så går det nå fint å slette en rad fra Students, da blir de radene relevant for den eleven sletta.
);


-- 'DELETE FROM students' FAILER uten en key constraint! Den er en parent til Events, fordi en kolonne i Events REFERERER til en kolonne i Students! Ergo, blir den lest som en forelder/parent, og uten en ordre for hvordan å håndtere "familien" når et barn skal bli foreldreløst, så kan ikke en rad til foreldren bli drept (slettet).
-- med andre ord, trenger Events en ON DELETE [SET NULL || CASCADE] når man beskriver kolonnen som skal bli barn til Students.studentId.

