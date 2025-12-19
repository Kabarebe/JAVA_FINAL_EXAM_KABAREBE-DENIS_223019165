package hospital.model;
import java.sql.Timestamp;

public class Service {

	private int serviceID;
	private String name;
	private String description;
	private String category;
	private String Status;
	private double PriceOrValue;
	private Timestamp createdAt;
	private Integer guestID;

	public Service() {}

	public Service(String name, String description, String category, double PriceOrValue, String status) {
		this.name = name;
		this. description = description;
		this.category = category;
		this.PriceOrValue = PriceOrValue;
		this.Status = status;
	}
	public int getServiceID() {
		return serviceID;
	}

	public void setServiceID(int serviceID) {
		this.serviceID = serviceID;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getStatus() {
		return Status;
	}

	public void setStatus(String status) {
		Status = status;
	}

	public double getPriceOrValue() {
		return PriceOrValue;
	}

	public void setPriceOrValue(double PriceOrValue) {
		this.PriceOrValue = PriceOrValue;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	public Integer getGuestID() {
		return guestID;
	}

	public void setGuestID(Integer guestID) {
		this.guestID = guestID;
	}


}

