package hospital.dao;
import hospital.db.DBConnection;
import hospital.model.Service;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ServiceDAO {

	public List<Service> getALLServices(){
		List<Service> services = new ArrayList<>();
		String sql = "SELECT * FROM service WHERE Status ='Available'";
		try(Connection conn = DBConnection.getConnection();
				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery(sql)){
			
			while(rs.next()) {
				Service service = new Service();
				service.setServiceID(rs.getInt("ServiceID"));
				service.setName(rs.getString("Name"));
				service.setDescription(rs.getString("Description"));
				service.setCategory(rs.getString("Category"));
				service.setPriceOrValue(rs.getDouble("PriceOrValue"));
				service.setStatus(rs.getString("Status"));
				services.add(service);
			}
			} catch(SQLException e) {
				e.printStackTrace();
			}
		return services;
	}
}


