class Cordonee {
    private int i,j;

    Cordonee(int i,int j) {
        this.i = i;
        this.j = j;
    }

    int getI() {
        return this.i;
    }

    int getJ() {
        return this.j;
    }

    void setI(int i) {
        this.i = i;
    }

    void setJ(int j) {
        this.j = j;
    }

    void affiche() {
        println("{i:"+this.i+",j:"+this.j+"}");
    }
}