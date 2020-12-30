/**
 * Created by changcan on 2018/6/28.
 */

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.*;

@WebListener()
public class MyServletContextListener implements ServletContextListener,
        HttpSessionListener, HttpSessionAttributeListener,HttpSessionBindingListener
    ,HttpSessionActivationListener
{
    static private int activeSessions;

    public static int getActiveSessions() {
        return activeSessions;
    }

    // Public constructor is required by servlet spec
    public MyServletContextListener() {
    }

    @Override
    public void valueBound(HttpSessionBindingEvent event) {
        System.out.println("HttpSessionBindingListener   --valueBound");
        System.out.println(event.getName()+":"+event.getValue());
    }

    @Override
    public void valueUnbound(HttpSessionBindingEvent event) {
        System.out.println("HttpSessionBindingListener   --valueUnbound");
        System.out.println(event.getName()+":"+event.getValue());
    }

    // -------------------------------------------------------
    // ServletContextListener implementation
    // -------------------------------------------------------
    public void contextInitialized(ServletContextEvent sce) {
      /* This method is called when the servlet context is
         initialized(when the Web application is deployed). 
         You can initialize servlet context related data here.
      */

        ServletContext sc=sce.getServletContext();
        String contextConfigLocation=sc.getInitParameter("contextConfigLocation");
        System.out.println(contextConfigLocation);
        sc.setAttribute("contextConfigLocation1",contextConfigLocation);
    }

    public void contextDestroyed(ServletContextEvent sce) {
      /* This method is invoked when the Servlet Context 
         (the Web application) is undeployed or 
         Application Server shuts down.
      */
        System.out.println("");
    }

    // -------------------------------------------------------
    // HttpSessionListener implementation
    // -------------------------------------------------------
    public void sessionCreated(HttpSessionEvent se) {
      /* Session is created. */
        /*HttpSession session=se.getSession();
        if (session.isNew()){
            System.out.println("首次登陆<br>");
        }else{
            System.out.println("欢迎回来<br>");
        }*/
        activeSessions++;
        System.out.println("建立了新的session");
    }

    public void sessionDestroyed(HttpSessionEvent se) {
      /* Session is destroyed. */
      activeSessions--;
        System.out.println("销毁session");
    }

    // -------------------------------------------------------
    // HttpSessionAttributeListener implementation
    // -------------------------------------------------------

    public void attributeAdded(HttpSessionBindingEvent sbe) {
      /* This method is called when an attribute 
         is added to a session.
      */
        System.out.println("attribute added:"+sbe.getName()+":"+sbe.getValue());
    }

    public void attributeRemoved(HttpSessionBindingEvent sbe) {
      /* This method is called when an attribute
         is removed from a session.
      */
        System.out.println("attribute removed:"+sbe.getName()+":"+sbe.getValue());
    }

    public void attributeReplaced(HttpSessionBindingEvent sbe) {
      /* This method is invoked when an attibute
         is replaced in a session.
      */
        System.out.println("attribute replaced:"+sbe.getName()+":"+sbe.getValue());
    }

    @Override
    public void sessionWillPassivate(HttpSessionEvent se) {
        System.out.println("HttpSessionActivationListener  ----sessionWillPassivate");
    }

    @Override
    public void sessionDidActivate(HttpSessionEvent se) {
        System.out.println("HttpSessionActivationListener  ----sessionDidActivate");

    }
}
