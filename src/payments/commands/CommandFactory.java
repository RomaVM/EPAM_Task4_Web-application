package payments.commands;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

public class CommandFactory {
    private static Map<String,Command> commandMap = new HashMap<>();
    static {
        commandMap.put("sign in", new LoginCommand());
        commandMap.put("sign up", new SignUpCommand());
    }

    public static Command getCommand(HttpServletRequest request) {
        String value = request.getParameter("ok");
        return commandMap.get(value);
    }
}
