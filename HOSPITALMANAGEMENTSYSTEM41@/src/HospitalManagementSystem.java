import hospital.gui.LoginFrame;
public class HospitalManagementSystem {

	public static void main(String[] args) {
		java.awt.EventQueue.invokeLater(new Runnable() {
			public void run() {
				new LoginFrame().setVisible(true);
			}
		});
	}
}

