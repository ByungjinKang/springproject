package org.zerock.board.mapper;

import org.zerock.board.domain.BoardVO;
import org.zerock.common.domain.Criteria;

import java.util.List;

public interface BoardMapper {

//    @Select("select * from tbl_board where bno > 0")
    public List<BoardVO> getList();


    public List<BoardVO> getList2();

    public void insert(BoardVO board);

    public void insertSelectKey(BoardVO board);

    public BoardVO read(Long bno);

    public int delete(Long bno);

    public int update(BoardVO board);
}
