<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@include file="../includes/header.jsp"%>
<div class="row">
    <div class="col-sm-12">
        <h1 class="card-header">Board Read</h1>
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->



<div class="row">
    <div class="col-sm-12">
        <div class="card-body">

        <div class="card-title">Board Read Page</div>
            <!-- /.panel-heading -->
            <div class="card-body">

                <div class="form-group">
                    <label>Bno</label> <input class="form-control" name="Bno"
                    value='<c:out value="${board.bno }"/>' readonly="readonly">
                </div>

                <div class="form-group">
                    <label>Title</label> <input class="form-control" name="title"
                    value='<c:out value="${board.title }"/>' readonly="readonly">
                </div>

                <div class="form-group">
                    <label>Text area</label>
                    <textarea class="form-control" rows="3" name="content" readonly="readonly">
                 <c:out value="${board.content}"/> </textarea>
                </div>

                <div class="form-group">
                    <label>Writer</label> <input class="form-control" name="writer"
                     value='<c:out value="${board.writer }"/>' readonly="readonly">
                </div>

                <button data-oper='modify'
                        class="btn btn-outline-info btn-user">
                    Modify
                </button>
                <button data-oper='list'
                        class="btn btn-info btn-user">
                    List
                </button>

                <form id='operForm' action="/board/modify" method="get">
                    <input type='hidden' id='bno' name='bno' value='<c:out value="${board.bno}"/>'>
                </form>
            </div>
            <!-- end panel-body -->

        </div>
        <!-- end panel-body -->

    </div>
    <!-- end panel -->

</div>
<!-- /.row -->

<!-- /.panel -->
<div class="card-body panel">
    <div class ="header-panel">
        <i class="fa fa-comments fa-fw"></i> Reply
        <button id='addReplyBtn' class="btn btn-primary btn-xs right-button">New Reply</button>
    </div>
</div>


<div class = 'row'>
    <div class="col-sm-12">
        <!-- /.panel -->
        <div class="card-body">
            <div class="card-title">
            <!-- /.panel-heading -->
            <div class="panel">
                <ul class="chat">
                    <!-- start reply -->
                    <li class="list-inline" data-rno="12">
                        <div>
                            <div class="card-header">
                                <strong class="primary-font">user00</strong>
                                <small class="pull-right text-muted">2018-01-01 13:13</small>
                            </div>
                            <p>Good job!</p>
                        </div>
                    </li>
                    <!-- end reply -->
                </ul>
                <!-- ./ end ul -->
            </div>
            <!-- /.panel .chat-panel -->
        </div>
    </div>
    <!-- ./ end row -->
</div>

    <div class="card-footer">

    </div>

    <!-- Modal -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog"
         aria-labelledby="myModalLabel" aria-hidden="true">
        <div class = "modal-dialog">
            <div class = "modal-content">
                <div class = "modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label>Reply</label>
                        <input class="form-control" name='reply' value='New Reply!!!!'>
                    </div>
                    <div class="form-group">
                        <label>Replyer</label>
                        <input class="form-control" name='replyer' value='replyer'>
                    </div>
                    <div class="form-group">
                        <label>Reply Date</label>
                        <input class="form-control" name='replyDate' value=''>
                    </div>
                </div>
                <div class="modal-footer">
                    <button id="modalModBtn" type="button" class="btn btn-warning">Modify</button>
                    <button id="modalRemoveBtn" type="button" class="btn btn-danger">Remove</button>
                    <button id="modalRegisterBtn" type="button" class="btn btn-default" data-dismiss="modal">Register</button>
                    <button id="modalCloseBtn" type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

<script type="text/javascript" src="/resources/js/reply.js"></script>

<script>

    $(document).ready(function () {

        const bnoValue = '<c:out value="${board.bno}"/>';
        const replyUL = $(".chat");

        showList(1);

        <%--    댓글 페이지 번호를 출력하는 로직--%>
        var pageNum = 1;
        var replyPageFooter = $(".card-footer");

        function showReplyPage(replyCnt){

            var endNum = Math.ceil(pageNum / 10.0) * 10;
            var startNum = endNum - 9;

            var prev = startNum != 1;
            var next = false;

            if(endNum * 10 >= replyCnt){
                endNum = Math.ceil(replyCnt/10.0);
            }

            if(endNum * 10 < replyCnt){
                next = true;
            }

            var str = "<ul class='pagination pull-right'>";

            if(prev){
                str+= "<li class='page-item'><a class='page-link' href='"+(startNum -1)+"'>Previous</a></li>";
            }

            for(var i = startNum ; i <= endNum; i++) {
                    var active = pageNum == i? "active":"";

                    str+= "<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
                }

            if(next){
                str+= "<li class='page-item'><a class='page-link' href='"+(endNum + 1)+"'>Next</a></li>";
            }

            str += "</ul></div>";

            console.log(str);

            replyPageFooter.html(str);
        }

            function showList(page){

                console.log("show list " + page);

                replyService.getList({bno:bnoValue,page: page|| 1}, function(replyCnt, list) {

                console.log("replyCnt: "+ replyCnt );
                console.log("list: " + list);
                console.log(list);

                if(page == -1) {
                    pageNum = Math.ceil(replyCnt/10.0);
                    showList(pageNum);
                    return;
                }

                var str="";

                if(list == null || list.length == 0){
                    return;
                }

                for (var i = 0, len = list.length || 0; i < len; i++) {
                    str +="<li class='list-unstyled' data-rno='"+list[i].rno+"'>";
                    str +=" <div><div class = 'nav-tabs'> <strong class = 'primary-font'>"+list[i].replyer+"</strong>";
                    str +=" <small class = 'float-right text-muted'>"+replyService.displayTime(list[i].replyDate)+"</small></div>";
                    str +=" <p>"+list[i].reply+"</p></div></li>";
                }

                replyUL.html(str);

                showReplyPage(replyCnt);
                });//end function
            }//end showList

        const modal = $(".modal");
        const modalInputReply = modal.find("input[name='reply']");
        const modalInputReplyer = modal.find("input[name='replyer']");
        const modalInputReplyDate = modal.find("input[name='replyDate']");

        const modalModBtn = $("#modalModBtn");
        const modalRemoveBtn = $("#modalRemoveBtn");
        const modalRegisterBtn = $("#modalRegisterBtn");

        $("#addReplyBtn").on("click", function(e){

            modal.find("input").val("");
            modalInputReplyDate.closest("div").hide();
            modal.find("button[id !='modalCloseBtn']").hide();

            modalRegisterBtn.show();

            $(".modal").modal("show");

            modalRegisterBtn.on("click", function(e){

                const reply = {
                    reply: modalInputReply.val(),
                    replyer:modalInputReplyer.val(),
                    bno:bnoValue
                };
                replyService.add(reply, function(result){

                    alert(result);

                    modal.find("input").val("");
                    modal.modal("hide");

                    //showList(1);
                    showList(-1);
                });
            });
         });

        $(".chat").on("click", "li", function(e){

        var rno = $(this).data("rno");

        replyService.get(rno, function(reply){

            modalInputReply.val(reply.reply);
            modalInputReplyer.val(reply.replyer);
            modalInputReplyDate.val(replyService.displayTime( reply.replyDate))
                .attr("readonly", "readonly");
            modal.data("rno", reply.rno);

            modal.find("button[id !='modalCloseBtn']").hide();
            modalModBtn.show();
            modalRemoveBtn.show();

            $(".modal").modal("show");
            });

        });
        // modalModBtn.on("click", function(e){
        //
        //     var reply = {rno:modal.data("rno"), reply: modalInputReply.val()};
        //
        //     replyService.update(reply, function(result){
        //
        //         alert(result);
        //         modal.modal("hide");
        //         showList(1);
        //     });
        // });

        //댓글이 페이지 처리되면 댓글의 수정과 삭제 시에도 현재 댓글이 포함된 페이지로 이동
        modalModBtn.on("click", function(e){

            var reply = {rno:modal.data("rno"), reply: modalInputReply.val()};

            replyService.update(reply, function(result){

                alert(result);
                modal.modal("hide");
                showList(pageNum);
            });
        });

        // modalRemoveBtn.on("click", function(e){
        //
        //     var rno = modal.data("rno");
        //
        //     replyService.remove(rno, function(result){
        //
        //         alert(result);
        //         modal.modal("hide");
        //         showList(1);
        //     });
        // });
        modalRemoveBtn.on("click", function (e){

            var rno = modal.data("rno");

            replyService.remove(rno, function(result){

                alert(result);
                modal.modal("hide");
                showList(pageNum);
            });
        });



        //페이지 번호를 클릭했을 때 새로운 댓글을 가져옴
        replyPageFooter.on("click", "li a", function(e){
            e.preventDefault();
            console.log("page click");

            var targetPageNum = $(this).attr("href");

            console.log("targetPageNum: " + targetPageNum);

            pageNum = targetPageNum;

            showList(pageNum);
        });

    });

</script>

<%--    replyService 로그 출력--%>
<script type="text/javascript">
    $(document).ready(function() {
        console.log(replyService);
    });
</script>

<%--    CRUD alert 출력--%>
<%--<script>--%>
<%--    console.log("=============")--%>
<%--    console.log("JS TEST");--%>

<%--    const bnoValue = '<c:out value="${board.bno}"/>';--%>

<%--    //for replyService add test--%>
<%--    replyService.add(--%>
<%--        {reply:"JS Test", replyer:"tester", bno:bnoValue}--%>
<%--        ,--%>
<%--        function(result){--%>
<%--            alert("RESULT: " + result);--%>
<%--        }--%>
<%--    )--%>
<%--    console.log("=============")--%>
<%--    console.log("JS TEST");--%>

<%--    replyService.getList({bno:bnoValue, page:1}, function(list){--%>

<%--        for(let i = 0, len = list.length||0; i < len; i++ ){--%>
<%--            console.log(list[i]);--%>
<%--        }--%>
<%--    });--%>

<%--    replyService.remove(23, function(count) {--%>

<%--        console.log(count);--%>

<%--        if (count === "success") {--%>
<%--            alert("REMOVED");--%>
<%--        }--%>
<%--    }, function(err) {--%>
<%--        alert('ERROR...');--%>
<%--    });--%>

<%--    replyService.update({--%>
<%--        rno : 22,--%>
<%--        bno : bnoValue,--%>
<%--        reply : "Modified Reply....."--%>
<%--    }, function(result) {--%>
<%--        alert("수정 완료...");--%>
<%--    });--%>

<%--    replyService.get(10, function(data){--%>
<%--        console.log(data);--%>
<%--    });--%>

<%--</script>--%>

<script type="text/javascript">
    $(document).ready(function() {

        const operForm = $("#operForm");

        $("button[data-oper='modify']").on("click", function(e) {
            operForm.attr("action", "/board/modify").submit();
        });

        $("button[data-oper='list']").on("click", function(e){

            operForm.find("#bno").remove();
            operForm.attr("action", "/board/list");
            operForm.submit();
        });
    });
</script>

<%@include file="../includes/footer.jsp" %>