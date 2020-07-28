package Entity;

public class FriendRequest {
    private String ID;
    private String fromUID;
    private String toUID;
    private int status;//0未处理，1同意，-1拒绝

    public FriendRequest(String ID, String fromUID, String toUID, int status) {
        this.ID = ID;
        this.fromUID = fromUID;
        this.toUID = toUID;
        this.status = status;
    }

    public String getID() {
        return ID;
    }

    public void setID(String ID) {
        this.ID = ID;
    }

    public String getFromUID() {
        return fromUID;
    }

    public void setFromUID(String fromUID) {
        this.fromUID = fromUID;
    }

    public String getToUID() {
        return toUID;
    }

    public void setToUID(String toUID) {
        this.toUID = toUID;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
}
