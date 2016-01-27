package payments.commands;

import payments.dao.ClientDAO;
import payments.dao.DAOFactory;
import payments.model.Client;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class SignUpCommand implements Command {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String firstName = request.getParameter("first_name");
        String lastName = request.getParameter("last_name");
        String password = request.getParameter("pass");
        String phoneNumber = request.getParameter("phone_number");
        Client c = new Client();
        c.setFirstName(firstName);
        c.setLastName(lastName);
        c.setPhoneNumber(phoneNumber);
        c.setPassword(password);
        DAOFactory factory = DAOFactory.getInstance();
        ClientDAO clientDao = factory.getClientDAO();
        boolean isAdd = false;
        boolean isPhoneNumberAlreadyExist = false;
        try {
            isPhoneNumberAlreadyExist = clientDao.isPasswordAlreadyExist(c);
            isAdd = clientDao.insertDataToClient(c);

        } catch (SQLException ex) {
            Logger.getLogger(SignUpCommand.class.getName()).log(Level.SEVERE, null, ex);
        }
        if(isPhoneNumberAlreadyExist && !isAdd){
            String alreadyUsed = "Этот номер уже используеться.";
            request.getSession().setAttribute("error_message", alreadyUsed);
            return "registration";
        }
        else if(isAdd && !isPhoneNumberAlreadyExist){
            return "/welcomeAdmin.jsp";
        } else {
            return "/errorSognUp.html";
        }
    }
}
