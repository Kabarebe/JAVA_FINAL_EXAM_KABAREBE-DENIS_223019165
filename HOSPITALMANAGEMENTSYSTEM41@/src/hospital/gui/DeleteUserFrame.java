package hospital.gui;
import hospital.dao.GuestDAO;
import hospital.model.Guest;
import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.List;

public class DeleteUserFrame extends JFrame  {
	private JComboBox<Guest> userComboBox;
	private JTextField userIdField;
	private JButton deleteByIdButton;

	public DeleteUserFrame() {
		initializeUI();
		loadUsers();
	}

	private void initializeUI() {
		setTitle("Delete User");
		setSize(500, 300);
		setLocationRelativeTo(null);
		setResizable(false);

		JPanel mainPanel = new JPanel(new BorderLayout(10,10));
		mainPanel.setBorder(BorderFactory.createEmptyBorder(20,20,20,20));

		JTabbedPane tabbedPane = new JTabbedPane();

		JPanel listPanel = new JPanel(new BorderLayout(10, 10));
		JPanel listFormPanel = new JPanel(new FlowLayout());
		listFormPanel.add(new JLabel("Select User to Delete:"));
		userComboBox = new JComboBox<>();
		userComboBox.setPreferredSize(new Dimension(200, 25));
		listFormPanel.add(userComboBox);
		listPanel.add(listFormPanel, BorderLayout.NORTH);

		JPanel listButtonPanel = new JPanel(new FlowLayout());
		JButton deleteFromListButton = new JButton("Delete Selected User");
		listButtonPanel.add(deleteFromListButton);
		listPanel.add(listButtonPanel, BorderLayout.SOUTH);

		JPanel idPanel = new JPanel(new BorderLayout(10, 10));
		JPanel idFormPanel = new JPanel(new GridLayout(2, 2, 10, 10));
		idFormPanel.add(new JLabel("Enter User ID:"));
		userIdField = new JTextField();
		idFormPanel.add(userIdField);
		idFormPanel.add(new JLabel(""));
		deleteByIdButton = new JButton("Delete by ID");
		idFormPanel.add(deleteByIdButton);
		idPanel.add(idFormPanel, BorderLayout.CENTER);

		tabbedPane.addTab("Select from List", listPanel);
		tabbedPane.addTab("Delete by ID", idPanel);

		mainPanel.add(tabbedPane, BorderLayout.CENTER);

		JPanel commonButtonPane = new JPanel(new FlowLayout());
		JButton cancelButton = new JButton("Cancel");
		commonButtonPane.add(cancelButton);
		mainPanel.add(commonButtonPane, BorderLayout.SOUTH);

		add(mainPanel);

		deleteFromListButton.addActionListener(new DeleteFromListListener());
		deleteByIdButton.addActionListener(new DeleteByIdListener());
		cancelButton.addActionListener(e -> dispose());
	}

	private void loadUsers() {
		GuestDAO guestDAO = new GuestDAO();
		List<Guest> guests = guestDAO.getAllGuests();

		userComboBox.removeAllItems();
		for (Guest guest : guests) {
			userComboBox.addItem(guest);
		}
	}

	private class DeleteFromListListener implements ActionListener {
		public void actionPerformed(ActionEvent e) {
			Guest selectedGuest = (Guest) userComboBox.getSelectedItem();
			if (selectedGuest == null) {
				JOptionPane.showMessageDialog(DeleteUserFrame.this,"Please select a user to delete", "Error", JOptionPane.ERROR_MESSAGE);
				return;
			}
			deleteUser(selectedGuest.getGuestID(), selectedGuest.getFullName());
		}
	}
	private class DeleteByIdListener implements ActionListener {
		public void actionPerformed(ActionEvent e) {
			String userIdText = userIdField.getText().trim();
			if (userIdText.isEmpty()) {
				JOptionPane.showMessageDialog(DeleteUserFrame.this,"Please enter a User ID", "Error", JOptionPane.ERROR_MESSAGE);
				return;
			}
			try {
				int userId = Integer.parseInt(userIdText);
				deleteUser(userId, "User ID: " + userId);
			} catch (NumberFormatException ex) {
				JOptionPane.showMessageDialog(DeleteUserFrame.this,"Please enter a avalid numeric User ID", "Error", JOptionPane.ERROR_MESSAGE);
			}
		}

	}

	private void deleteUser(int userId, String userInfo) {
		int confirmation = JOptionPane.showConfirmDialog(DeleteUserFrame.this,"Are you sure you want to delete user: " + userInfo + "?","Confirm Deletion",JOptionPane.YES_NO_OPTION);
		if (confirmation == JOptionPane.YES_NO_OPTION) {
			GuestDAO guestDAO = new GuestDAO();
			if(guestDAO.deleteGuest(userId)) {
				JOptionPane.showMessageDialog(DeleteUserFrame.this,"User deleted successfully!", "Success", JOptionPane.INFORMATION_MESSAGE);
				loadUsers();
				userIdField.setText("");
			}
			else {
				JOptionPane.showMessageDialog(DeleteUserFrame.this,"Failed to delete user. User ID may not exists.", "Error", JOptionPane.ERROR_MESSAGE);
			}
		}
	}

}

