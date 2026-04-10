package teaher;

public class Subject {
    private String name;
    private String code;
    private int workload;

    public Subject(String name, String code, int workload) {
        this.name = name;
        this.code = code;
        this.workload = workload;
    }

    public String getName() {
        return this.name;
    }

    public String getCode() {
        return this.code;
    }

    public int getWorkload() {
        return this.workload;
    }
}
