package payments.commands;

import payments.dao.ClientDAO;
import payments.dao.DAOFactory;
import payments.model.Client;

import javax.jms.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class LoginCommand implements Command {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String phoneNumber = request.getParameter("phone");
        String password = request.getParameter("pass");
        Client c = new Client();
        c.setPhoneNumber(phoneNumber);
        c.setPassword(password);
        DAOFactory factory=DAOFactory.getInstance();
        ClientDAO clientDao=factory.getClientDAO();
        boolean isAdminExist = false;
        boolean isClientExist = false;
        try {
            isAdminExist = clientDao.isAdminExist(c);
            isClientExist = clientDao.isClientExist(c);
            c = clientDao.findClient(phoneNumber, password);
        } catch (SQLException ex) {
            Logger.getLogger(LoginCommand.class.getName()).log(Level.SEVERE, null, ex);
        }
        if(isClientExist && !isAdminExist){
            request.setAttribute("client", c);
            return "/welcomeClient.jsp";
        }
        else if(isAdminExist && !isClientExist) {
            request.setAttribute("client", c);
            return "welcomeAdmin";
        } else {
            return "/index.jsp";
        }
    }
}
