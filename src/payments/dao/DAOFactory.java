package payments.dao;


import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DAOFactory {
    private static DAOFactory instance = null;
    DataSource ds;

    private DAOFactory() throws NamingException{
        InitialContext initContext= new InitialContext();
        ds = (DataSource)initContext.lookup("java:comp/env/jdbc/payments");

    }

    public static synchronized DAOFactory getInstance(){
        if(instance == null){
            try {
                instance = new DAOFactory();
            } catch (NamingException ex) {
                Logger.getLogger(DAOFactory.class.getName()).log(Level.SEVERE, null, ex);
            }

        }
        return instance;
    }

    public ClientDAO getClientDAO(){
        return new ClientDAO(ds);
    }
}