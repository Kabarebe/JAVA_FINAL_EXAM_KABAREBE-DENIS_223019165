package hospital.gui;
import hospital.dao.GuestDAO;
import hospital.model.Guest;
import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class LoginFrame extends JFrame {
	private JTextField usernameField;
	private JPasswordField passwordField;
	private JCheckBox staffCheckBox;
	private JButton loginButton;
	private JButton registerButton;

	public LoginFrame() {
		initializeUI();
	}

	private void initializeUI() {
		setTitle("Hospitality Management System - Login");
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setSize(400, 300);
		setLocationRelativeTo(null);
		setResizable(false);
		JPanel mainPanel = new JPanel(new BorderLayout(10,10));
		mainPanel.setBorder(BorderFactory.createEmptyBorder(20,20,20,20));

		JLabel titleLabel = new JLabel("Hospitality Management System",JLabel.CENTER);
		titleLabel.setFont(new Font("Arial", Font.BOLD,18));
		mainPanel.add(titleLabel,BorderLayout.NORTH);
		JPanel formPanel = new JPanel(new GridLayout(4,2,10,10));

		formPanel.add(new JLabel("Username:"));
		usernameField = new JTextField();
		formPanel.add(usernameField);

		formPanel.add(new JLabel("Password:"));
		passwordField = new JPasswordField();
		formPanel.add(passwordField);

		formPanel.add(new JLabel(""));
		staffCheckBox = new JCheckBox("I am a Staff Member");
		formPanel.add(staffCheckBox);

		JPanel buttonPanel = new JPanel(new FlowLayout());
		loginButton = new JButton("Login");
		registerButton = new JButton("Register");

		buttonPanel.add(loginButton);
		buttonPanel.add(registerButton);

		formPanel.add(new JLabel(""));
		formPanel.add(buttonPanel);

		mainPanel.add(formPanel, BorderLayout.CENTER);

		add(mainPanel);

		loginButton.addActionListener(new LoginButtonListener());
		registerButton.addActionListener(new RegisterButtonListener());

	}


	private class LoginButtonListener implements ActionListener {
		public void actionPerformed(ActionEvent e) {
			String username = usernameField.getText().trim();
			String password = new String(passwordField.getPassword());
			boolean isStaff = staffCheckBox.isSelected();

			if (username.isEmpty() || password.isEmpty()) {
				JOptionPane.showMessageDialog(LoginFrame.this,"Please enter both username and password","Error",JOptionPane.ERROR_MESSAGE);
				return;
			}
			GuestDAO guestDAO = new GuestDAO();
			Guest guest = guestDAO.authenticate(username, password);

			if(guest != null) {
				if((isStaff && guest.getRole().equals("Admin")) || (!isStaff && !guest.getRole().equals("Admin"))) {
					JOptionPane.showMessageDialog(LoginFrame.this,"Login successful! Welcome"+ guest.getFullName(),"Success",JOptionPane.INFORMATION_MESSAGE);
					if (isStaff) {
						new StaffDashboardFrame(guest).setVisible(true);
					}
					else {
						new GuestDashboardFrame(guest).setVisible(true);
					}
					dispose();
				}else {
					JOptionPane.showMessageDialog(LoginFrame.this,"Role mismatch. Please check the staff checkbox.","Error",JOptionPane.ERROR_MESSAGE);
				}
			} else {
				JOptionPane.showMessageDialog(LoginFrame.this,"Invalid username or Password","Error",JOptionPane.ERROR_MESSAGE);
			}
		}
	}

	private class RegisterButtonListener implements ActionListener {
		public void actionPerformed(ActionEvent e) {
			new RegisterFrame().setVisible(true);
		}
	}
}

