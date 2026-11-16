package com.fenglin.springboottest.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 首页短视频实体，对应数据库表 video
 */
@Data
@TableName("video")
public class Video {

    /** 主键 id，自增 */
    @TableId(type = IdType.AUTO)
    private Long id;

    /** 视频标题 */
    private String title;

    /** 作者 */
    private String author;

    /** 简介 */
    private String description;

    /** 视频地址，如 /videos/video1.mp4（前端按此地址播放） */
    private String videoUrl;

    /** 点赞数 */
    private Integer likes;

    /** 评论数 */
    private Integer comments;

    /** 录入时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createTime;
}
