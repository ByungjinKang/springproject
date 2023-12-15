package org.zerock.reply.mapper;

import org.apache.ibatis.annotations.Param;
import org.zerock.common.domain.Criteria;
import org.zerock.reply.domain.ReplyVO;

import java.util.List;

public interface ReplyMapper {

    public int insert(ReplyVO vo);

    public ReplyVO read(Long bno);

    public int delete (Long rno);

    public int update(ReplyVO reply);

    public List<ReplyVO> getListWithPaging(
            @Param("cri") Criteria cri,
            @Param("bno") Long bno);

    public int getCountByBno(Long bno);
}
