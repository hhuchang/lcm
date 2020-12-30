package com.action;



import com.Utils.EncryptUtil;
import com.entity.Admin;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.util.ValueStack;
import com.service.AdminService;
import org.apache.commons.lang.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;

/**
 * Created by changcan on 2018/9/17.
 */
@Controller
@Scope("prototype")
public class AdminAction extends ActionSupport implements ServletRequestAware{
    @Autowired
    private AdminService adminService;


    HttpServletRequest request;

    /**
     * 获取所用管理员信息
     * @return
     */
    public String getAllAdmin(){

        List<Admin> admins=adminService.findAll();
        ActionContext ctx=ActionContext.getContext();
        ValueStack stack=ctx.getValueStack();
        stack.set("adminlist",admins);
        //request.setAttribute("adminlist",admins);
        return "admin_list";
    }

    /**
     * 修改管理密码
     * @return
     */
    public String updateAdmin(){
        String admin_id=request.getParameter("admin_id");
        String newPass=request.getParameter("newPass");
        //如果密码留白则说明没有修改密码的诚意，则跳转到所用列表里面去，
        if(StringUtils.isNotEmpty(newPass)){
            if (StringUtils.isNotEmpty(admin_id)){
                int id=Integer.parseInt(admin_id);
                adminService.updatePassWord(EncryptUtil.encryptString(newPass),id);

            }
        }
        return getAllAdmin();
    }

    /**
     * 删除管理员
     * @return
     */
    public String deleteById(){
        String admin_id=request.getParameter("id");
        if (StringUtils.isNotEmpty(admin_id)){
            int id=Integer.parseInt(admin_id);
            adminService.delete(id);

        }
        return getAllAdmin();
    }
    public String addAdmin(){
        String username=request.getParameter("username");
        String password=request.getParameter("password");
        String admintype=request.getParameter("admintype");
        if (StringUtils.isNotEmpty(username)&&StringUtils.isNotEmpty(password)){
            Admin admin=new Admin();
            admin.setUsername(username);
            admin.setPassword(EncryptUtil.encryptString(password));
            //加入其他参数
            admin.setStatus(1);
            admin.setCreate_at(new Date());
            admin.setLast_update(new Date());
            admin.setEmail("emailTest");
            adminService.save(admin);
        }
        return getAllAdmin();
    }






    @Override
    public void setServletRequest(HttpServletRequest httpServletRequest) {
        request=httpServletRequest;
    }
}
