package payments.dao;

import payments.model.Client;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ClientDAO {
    static final String PHONENUMBER_EXIST = "select * from client "
            + "where phonenumber=?";
    static final String CLIENT_EXIST = "select * from client "
            + "where phonenumber=? and password=? and is_admin=false";
    static final String ADMIN_EXIST = "select * from client "
            + "where phonenumber=? and password=? and is_admin=true";
    static final String INSERT_NEW_CLIENT = "insert into client(firstname, lastname, password, phonenumber) "
            + "values(?,?,?,?)";

    DataSource ds;
    ClientDAO(DataSource ds) {
        this.ds = ds;
    }

    public boolean isClientExist(Client c) throws SQLException {
        Connection con = ds.getConnection();
        PreparedStatement ps = con.prepareStatement(CLIENT_EXIST);
        ps.setString(1, c.getPhoneNumber());
        ps.setString(2, c.getPassword());
        ResultSet rs = ps.executeQuery();
        return rs.next();
    }

    public boolean isAdminExist(Client c) throws SQLException {
        Connection con = ds.getConnection();
        PreparedStatement ps = con.prepareStatement(ADMIN_EXIST);
        ps.setString(1, c.getPhoneNumber());
        ps.setString(2, c.getPassword());
        ResultSet rs = ps.executeQuery();
        return rs.next();
    }

    public boolean isPasswordAlreadyExist(Client c) throws SQLException {
        Connection con = ds.getConnection();
        PreparedStatement ps = con.prepareStatement(PHONENUMBER_EXIST);
        ps.setString(1, c.getPhoneNumber());
        ResultSet rs = ps.executeQuery();
        return rs.next();
    }

    public Client findClient(String phone, String pass) throws SQLException {
        Connection con = ds.getConnection();
        PreparedStatement ps = con.prepareStatement(ADMIN_EXIST);
        Client client;
        ps.setString(1, phone);
        ps.setString(2, pass);
        ResultSet rs = ps.executeQuery();
            if(rs.next()){
                client = new Client();
                client.setFirstName(rs.getString("firstname"));
                client.setLastName(rs.getString("lastname"));
                return client;
            } else {
                return null;
            }
    }

    public boolean insertDataToClient(Client c) throws SQLException {
        Connection con = ds.getConnection();
        boolean exist = isClientExist(c) || isAdminExist(c);
        if(!exist) {
            PreparedStatement ps = con.prepareStatement(INSERT_NEW_CLIENT);
            ps.setString(1, c.getFirstName());
            ps.setString(2, c.getLastName());
            ps.setString(3, c.getPassword());
            ps.setString(4, c.getPhoneNumber());
            ps.execute();
            return true;
        } else {
            return false;
        }
    }
}
