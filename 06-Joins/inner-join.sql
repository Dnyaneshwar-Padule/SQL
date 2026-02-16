    INNER JOIN
    ----------

    Definition:
        INNER JOIN returns only those rows
        where the join condition matches in both tables.

        If there is no matching row in either table,
        that row is excluded from the result.

    In simple words:
        Only common (matching) data is returned.


    ------------------------------------------------------------

    Syntax:

        SELECT columns
        FROM table1
        INNER JOIN table2
        ON table1.column = table2.column;


    ------------------------------------------------------------

    Example Tables:

    student
    +-----+------+------+
    | rno | name | d_id |
    +-----+------+------+
    | 101 | AAA  | 1    |
    | 102 | BBB  | 2    |
    | 103 | CCC  | 1    |
    | 104 | DDD  | 5    |
    +-----+------+------+

    department
    +------+------+
    | d_id | name |
    +------+------+
    | 1    | CSE  |
    | 2    | CE   |
    | 3    | ME   |
    +------+------+


    ------------------------------------------------------------

    Query:

        SELECT s.name, d.name
        FROM student s
        INNER JOIN department d
        ON s.d_id = d.d_id;


    Result:

    +------+------+
    | name | name |
    +------+------+
    | AAA  | CSE  |
    | CCC  | CSE  |
    | BBB  | CE   |
    +------+------+

    Explanation:
        - Student AAA (d_id=1) matches CSE
        - Student CCC (d_id=1) matches CSE
        - Student BBB (d_id=2) matches CE
        - Student DDD (d_id=5) has no department → excluded

    Only matching rows are returned.


    ------------------------------------------------------------

    How INNER JOIN Works (Conceptually):

        1. Take first row from left table.
        2. Compare with rows in right table.
        3. If condition matches → combine rows.
        4. If no match → discard.
        5. Repeat for all rows.

    This is the logical behavior.
    Physically, database may use:
        - Nested Loop Join
        - Hash Join
        - Merge Join


    ------------------------------------------------------------

    Equivalent Old Syntax (Not Recommended):

        SELECT s.name, d.name
        FROM student s, department d
        WHERE s.d_id = d.d_id;

    This also works, but explicit JOIN is clearer.


    ------------------------------------------------------------

    Important Points:

        - INNER JOIN is default JOIN.
        (JOIN means INNER JOIN)

        - Rows without match are removed.

        - Join condition must be written carefully.
        Wrong condition can produce wrong results.

        - If no matching rows exist,
        result will be empty.


    ------------------------------------------------------------

    Mental Model:

        Think of INNER JOIN as:
            Intersection of two tables
            based on a condition.

        Only common matching relationships survive.


======================================================================================
                                Examples
======================================================================================
                            ## TABLE RECORDS ##
        MariaDB [test]> select * from student;
        +-----+-------+------+-----------+
        | rno | name  | per  | city      |
        +-----+-------+------+-----------+
        | 101 | Amit  |   85 | Pune      |
        | 102 | Neha  |   92 | Mumbai    |
        | 103 | Rohan |   67 | Delhi     |
        | 104 | Sneha |   91 | Pune      |
        | 105 | Vikas |   55 | Solapur   |
        | 106 | Rohit |   73 | Mumbai    |
        | 107 | Meera |   81 | Delhi     |
        | 108 | Aman  |   40 | Pune      |
        | 109 | Rhea  |   88 | Hyderabad |
        | 110 | Zara  |   95 | Mumbai    |
        +-----+-------+------+-----------+

        MariaDB [test]> select * from teacher;
        +-----+-------------+-----------+
        | tno | name        | city      |
        +-----+-------------+-----------+
        | 201 | Mehta Sir   | Pune      |
        | 202 | Roy Maam    | Mumbai    |
        | 203 | Patil Sir   | Delhi     |
        | 204 | Sharma Maam | Hyderabad |
        +-----+-------------+-----------+


        MariaDB [test]> select * from student_teacher;
        +-----+-----+------------+
        | rno | tno | l_date     |
        +-----+-----+------------+
        | 101 | 201 | 2025-01-01 |
        | 101 | 201 | 2025-01-02 |
        | 104 | 201 | 2025-01-01 |
        | 107 | 201 | 2025-01-02 |
        | 110 | 201 | 2025-01-04 |
        | 101 | 202 | 2025-01-03 |
        | 102 | 202 | 2025-01-01 |
        | 104 | 202 | 2025-01-06 |
        | 106 | 202 | 2025-01-04 |
        | 109 | 202 | 2025-01-03 |
        | 102 | 203 | 2025-01-02 |
        | 103 | 203 | 2025-01-01 |
        | 105 | 203 | 2025-01-03 |
        | 110 | 203 | 2025-01-04 |
        | 103 | 204 | 2025-01-05 |
        | 106 | 204 | 2025-01-06 |
        | 108 | 204 | 2025-01-01 |
        | 108 | 204 | 2025-01-02 |
        +-----+-----+------------+

    ##################################################################
    Q. List all students along with the teachers who taught them.
    ->select student.name, teacher.name, st.l_date 
    from student 
    join student_teacher as st
        on st.rno = student.rno 
    join teacher
        on st.tno = teacher.tno;
    
    +-------+-------------+------------+
    | name  | name        | l_date     |
    +-------+-------------+------------+
    | Amit  | Mehta Sir   | 2025-01-01 |
    | Amit  | Mehta Sir   | 2025-01-02 |
    | Sneha | Mehta Sir   | 2025-01-01 |
    | Meera | Mehta Sir   | 2025-01-02 |
    | Zara  | Mehta Sir   | 2025-01-04 |
    | Amit  | Roy Maam    | 2025-01-03 |
    | Neha  | Roy Maam    | 2025-01-01 |
    | Sneha | Roy Maam    | 2025-01-06 |
    | Rohit | Roy Maam    | 2025-01-04 |
    | Rhea  | Roy Maam    | 2025-01-03 |
    | Neha  | Patil Sir   | 2025-01-02 |
    | Rohan | Patil Sir   | 2025-01-01 |
    | Vikas | Patil Sir   | 2025-01-03 |
    | Zara  | Patil Sir   | 2025-01-04 |
    | Rohan | Sharma Maam | 2025-01-05 |
    | Rohit | Sharma Maam | 2025-01-06 |
    | Aman  | Sharma Maam | 2025-01-01 |
    | Aman  | Sharma Maam | 2025-01-02 |
    +-------+-------------+------------+


    Q.Show student name and teacher city
    for all matching student-teacher pairs.
    -> select student.name, teacher.city
    from student
    join student_teacher as st
        on st.rno = student.rno
    join teacher
        on st.tno = teacher.tno;

    +-------+-----------+
    | name  | city      |
    +-------+-----------+
    | Amit  | Pune      |
    | Amit  | Pune      |
    | Sneha | Pune      |
    | Meera | Pune      |
    | Zara  | Pune      |
    | Amit  | Mumbai    |
    | Neha  | Mumbai    |
    | Sneha | Mumbai    |
    | Rohit | Mumbai    |
    | Rhea  | Mumbai    |
    | Neha  | Delhi     |
    | Rohan | Delhi     |
    | Vikas | Delhi     |
    | Zara  | Delhi     |
    | Rohan | Hyderabad |
    | Rohit | Hyderabad |
    | Aman  | Hyderabad |
    | Aman  | Hyderabad |
    +-------+-----------+


    Q. List all teachers who have taught at least one student.
    -> select distinct teacher.name
    from teacher     
    join student_teacher as st     
    on teacher.tno = st.tno;
    
    +-------------+
    | name        |
    +-------------+
    | Mehta Sir   |
    | Roy Maam    |
    | Patil Sir   |
    | Sharma Maam |
    +-------------+


    Q.Show all students who have attended at least one lecture.
    ->select distinct student.name
    from student
    join on student_teacher as st
    on student.rno = st.rno;

    +-------+
    | name  |
    +-------+
    | Amit  |
    | Sneha |
    | Meera |
    | Zara  |
    | Neha  |
    | Rohit |
    | Rhea  |
    | Rohan |
    | Vikas |
    | Aman  |
    +-------+


    Q. Show student name, teacher name,
    but only for lectures held on '2025-01-01'.

    -> select student.name, teacher.name
    from student 
    join student_teacher as st
        on student.rno = st.rno
    join teacher
        on st.tno = teacher.tno
    where st.l_date = '2025-01-01';

    +-------+-------------+
    | name  | name        |
    +-------+-------------+
    | Amit  | Mehta Sir   |
    | Sneha | Mehta Sir   |
    | Neha  | Roy Maam    |
    | Rohan | Patil Sir   |
    | Aman  | Sharma Maam |
    +-------+-------------+




    Q. Show all students who were taught by teachers
        from the same city as the student.

    -> select student.name, teacher.name, student.city
    from student
    join student_teacher as st
        on st.rno = student.rno
    join teacher
        on st.tno =  teacher.tno
    where student.city = teacher.city;

    +-------+-----------+--------+
    | name  | name      | city   |
    +-------+-----------+--------+
    | Amit  | Mehta Sir | Pune   |
    | Amit  | Mehta Sir | Pune   |
    | Sneha | Mehta Sir | Pune   |
    | Neha  | Roy Maam  | Mumbai |
    | Rohit | Roy Maam  | Mumbai |
    | Rohan | Patil Sir | Delhi  |
    +-------+-----------+--------+



    Q. Count how many lectures each student attended.
    
    -> select student.name, count(*)
    from student
    join student_teacher as st
    on student.rno = st.rno
    group by student.rno, student.name; 

    +-------+----------+
    | name  | count(*) |
    +-------+----------+
    | Amit  |        3 |
    | Neha  |        2 |
    | Rohan |        2 |
    | Sneha |        2 |
    | Vikas |        1 |
    | Rohit |        2 |
    | Meera |        1 |
    | Aman  |        2 |
    | Rhea  |        1 |
    | Zara  |        2 |
    +-------+----------+



    Q. Count how many students each teacher has taught.
    -> select distinct teacher.name, count(*) as students_taught
    from teacher
    join student_teacher as st
    on teacher.tno = st.tno
    group by st.rno,teacher.tno, teacher.name;

    +-------------+-----------------+
    | name        | students_taught |
    +-------------+-----------------+
    | Mehta Sir   |               2 |
    | Roy Maam    |               1 |
    | Patil Sir   |               1 |
    | Sharma Maam |               1 |
    | Mehta Sir   |               1 |
    | Sharma Maam |               2 |
    +-------------+-----------------+


    Q. Show student name and number of different teachers
        they have attended.

    -> select student.name, 


    select student.name from student_teacher join (       select max(l_date) as last_lecture from student_teacher as st     ) as X on student_teacher.l_date = X.last_lecture;


