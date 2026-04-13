package teacher;

import java.util.ArrayList;

public class Teacher {
    private String name;
    private String degree;
    private String department;
    private ArrayList<Subject> subjects;

    public Teacher(String name, String degree, String department) {
        this.name = name;
        this.degree = degree;
        this.department = department;
        this.subjects = new ArrayList<>();
    }

    public Teacher(String name, String degree, String department, ArrayList<Subject> subjects) {
        this.name = name;
        this.degree = degree;
        this.department = department;
        this.subjects = subjects;
    }

    public void addSubject(Subject subject) {
        if (this.subjects.contains(subject)) {
            System.out.println("Subject already exists");
            return;
        }
        this.subjects.add(subject);
    }

    public void listSubjects() {
        for (Subject subject : this.subjects) {
            System.out.println(subject.getName());
        }
    }

    public String getName() {
        return this.name;
    }

    public String getDegree() {
        return this.degree;
    }

    public String getDepartment() {
        return this.department;
    }
}
