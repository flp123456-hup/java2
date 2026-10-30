package com.fenglin.springboottest.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 登录记录实体类，对应数据库表 login_record
 * 用于统计登录人数/登录次数
 */
@Data
@TableName("login_record")
public class LoginRecord {

    /** 主键 id，自增 */
    @TableId(type = IdType.AUTO)
    private Long id;

    /** 登录用户名 */
    private String username;

    /** 登录时间 */
    private LocalDateTime loginTime;

    /** 录入时间 */
    private LocalDateTime createTime;
}
