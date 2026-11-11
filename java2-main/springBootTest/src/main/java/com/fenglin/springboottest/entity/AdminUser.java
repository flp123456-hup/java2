package com.fenglin.springboottest.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 后台管理员实体类，对应数据库表 admin_user
 * （表和初始账号 admin/admin123 已在 sql/xiyangyang.sql 中建好）
 */
@Data
@TableName("admin_user")
public class AdminUser {

    /** 主键 id，自增 */
    @TableId(type = IdType.AUTO)
    private Long id;

    /** 管理员账号（唯一） */
    private String username;

    /** 密码（明文，学习演示用） */
    private String password;

    /** 创建时间 */
    private LocalDateTime createTime;
}
