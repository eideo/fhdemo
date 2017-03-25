package com.fh.dao.infor;

import com.fh.entity.infor.Picture;
import com.fh.entity.infor.PictureExample;
import java.util.List;

public interface PictureMapper {
    int deleteByPrimaryKey(String picturesId);

    int insert(Picture record);

    int insertSelective(Picture record);

    List<Picture> selectByExample(PictureExample example);

    Picture selectByPrimaryKey(String picturesId);

    int updateByPrimaryKeySelective(Picture record);

    int updateByPrimaryKey(Picture record);
}