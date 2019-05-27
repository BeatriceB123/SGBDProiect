package entities;

public class ExchangeRate {
    private float gbpToEur;
    private float gbpToRon;
    private float gbpToRub;

    private float eurToGbp;
    private float eurToRon;
    private float eurToRub;

    private float ronToGbp;
    private float ronToEur;
    private float ronToRub;

    private float rubToGbp;
    private float rubToEur;
    private float rubToRon;

    public void setExchangesRates(float gbpToEur, float gbpToRon, float gbpToRub, float eurToGbp, float eurToRon, float eurToRub,
                            float ronToGbp, float ronToEur, float ronToRub, float rubToGbp, float rubToEur, float rubToRon) {

        this.gbpToEur = gbpToEur;
        this.gbpToRon = gbpToRon;
        this.gbpToRub = gbpToRub;

        this.eurToGbp = eurToGbp;
        this.eurToRon = eurToRon;
        this.eurToRub = eurToRub;

        this.ronToGbp = ronToGbp;
        this.ronToEur = ronToEur;
        this.ronToRub = ronToRub;

        this.rubToGbp = rubToGbp;
        this.rubToEur = rubToEur;
        this.rubToRon = rubToRon;
    }

    public void setGbpToEur(float gbpToEur) {
        this.gbpToEur = gbpToEur;
    }

    public void setGbpToRon(float gbpToRon) {
        this.gbpToRon = gbpToRon;
    }

    public void setGbpToRub(float gbpToRub) {
        this.gbpToRub = gbpToRub;
    }

    public void setEurToGbp(float eurToGbp) {
        this.eurToGbp = eurToGbp;
    }

    public void setEurToRon(float eurToRon) {
        this.eurToRon = eurToRon;
    }

    public void setEurToRub(float eurToRub) {
        this.eurToRub = eurToRub;
    }

    public void setRonToGbp(float ronToGbp) {
        this.ronToGbp = ronToGbp;
    }

    public void setRonToEur(float ronToEur) {
        this.ronToEur = ronToEur;
    }

    public void setRonToRub(float ronToRub) {
        this.ronToRub = ronToRub;
    }

    public void setRubToGbp(float rubToGbp) {
        this.rubToGbp = rubToGbp;
    }

    public void setRubToEur(float rubToEur) {
        this.rubToEur = rubToEur;
    }

    public void setRubToRon(float rubToRon) {
        this.rubToRon = rubToRon;
    }

    public float getGbpToEur() {
        return gbpToEur;
    }

    public float getGbpToRon() {
        return gbpToRon;
    }

    public float getGbpToRub() {
        return gbpToRub;
    }

    public float getEurToGbp() {
        return eurToGbp;
    }

    public float getEurToRon() {
        return eurToRon;
    }

    public float getEurToRub() {
        return eurToRub;
    }

    public float getRonToGbp() {
        return ronToGbp;
    }

    public float getRonToEur() {
        return ronToEur;
    }

    public float getRonToRub() {
        return ronToRub;
    }

    public float getRubToGbp() {
        return rubToGbp;
    }

    public float getRubToEur() {
        return rubToEur;
    }

    public float getRubToRon() {
        return rubToRon;
    }
}


/*

    public Map<String, Integer> fromGBP = new HashMap<String, Integer>();
    public Map<String, Integer> fromEUR = new HashMap<String, Integer>();
    public Map<String, Integer> fromRON = new HashMap<String, Integer>();
    public Map<String, Integer> fromRUB = new HashMap<String, Integer>();

    public void setFromGBP(int gbp, int eur, int ron, int rub) {
        fromGBP.put("GBP", gbp);
        fromGBP.put("EUR", eur);
        fromGBP.put("RON", ron);
        fromGBP.put("RUB", rub);
    }

    public void setfromEUR(int gbp, int eur, int ron, int rub) {
        fromEUR.put("GBP", gbp);
        fromEUR.put("EUR", eur);
        fromEUR.put("RON", ron);
        fromEUR.put("RUB", rub);
    }

    public void setFromRON(int gbp, int eur, int ron, int rub) {
        fromRON.put("GBP", gbp);
        fromRON.put("EUR", eur);
        fromRON.put("RON", ron);
        fromRON.put("RUB", rub);
    }

    public void setFromRUB(int gbp, int eur, int ron, int rub) {
        fromRUB.put("GBP", gbp);
        fromRUB.put("EUR", eur);
        fromRUB.put("RON", ron);
        fromRUB.put("RUB", rub);
    }

    public Map<String, Integer> getFromGBP() {
        return fromGBP;
    }

    public Map<String, Integer> getFromEUR() {
        return fromEUR;
    }

    public Map<String, Integer> getFromRON() {
        return fromRON;
    }

    public Map<String, Integer> getFromRUB() {
        return fromRUB;
    }

 */