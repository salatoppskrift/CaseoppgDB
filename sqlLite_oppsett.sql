CREATE TABLE IF NOT EXISTS ny_Courses (
    "id" INT,
    "courseName" TEXT NOT NULL,
    PRIMARY KEY("id" AUTOINCREMENT)
);

CREATE TABLE IF NOT EXISTS ny_Students (
    studentId TEXT PRIMARY KEY NOT NULL,
    eventType INT,
    name TEXT NOT NULL,
    FOREIGN KEY(eventType) REFERENCES ny_Courses(id)
);

CREATE TABLE IF NOT EXISTS ny_Events (
    eventId TEXT PRIMARY KEY NOT NULL,
    studentId TEXT,
    courseId INT,
    FOREIGN KEY(studentId) REFERENCES ny_Students(studentId),
    FOREIGN KEY(courseId) REFERENCES ny_courses(id)
);

INSERT INTO ny_Courses (courseName)
   VALUES
     ("Start IT"), ("Intro"), ("FrontEnd"),
     ("BackEnd"), ("GET Prepared"), ("GET IT")
;

INSERT INTO ny_Students VALUES ("c87b943a-66f8-4", 2, "Demogoroth Satanum");

INSERT INTO ny_Events VALUES ("43a-66f8-42e8-9", "c87b943a-66f8-4", 2);

DELETE FROM ny_Events; -- funker!

INSERT INTO ny_Events VALUES ("43a-66f8-42e8-9", "c87b943a-66f8-4", 2); -- legge tilbake bc I'm a control freak!

DELETE FROM ny_Students; -- **ERROR!** Samme tingen som i mysql-eksemplet, dette er er en forelder og inntil du har spesifisert hva som hender når du sletter foreldren til et barn (ON DELETE SET NULL/CASCADE), så slår sql-en feil!

-- kan godt skrive ny_Events igjen eller lage en ny_Events_2, eller så kan vi bruke Sqlite mofidy table-greia dens v å høyreklikke på tabellen og velge "modify table", gå til *Foreign Keys*-kolonnen, se *References*, dobbelklikk der det står "ny_Students"("studentId"), og tast inn ON DELETE CASCADE. Du kan godt skrive ON DELETE SET NULL isteden, gjerne se hva som er forskjell på egen hånd! Igjen, cascade gjør at hvis en foreldrerad blir slettet, blir alle rader relatert til den som barn (der vi har SKREVET CASCADE) også slettet; hvis du skriver SET NULL, beholder vi barneradene og der det pleide å være foreldreid, står det nå NULL.
-- interessant øbservasjon: Sqlitefilen husker ikke når jeg endrer på ny_students tabellen. Lovely
