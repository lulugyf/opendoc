//初始化评分
var WindowVote = new GradeVote();

function GradeVote() {
    this.VoteMaxStar=1;
    this.VoteCounter=1;
    this.VoteContent=new Array();
    this.GradeVoteImage1=globalPathRoot+"/nresources/default/images/ico_star.gif";
    this.GradeVoteImage2=globalPathRoot+"/nresources/default/images/ico_star_grey.gif";
	
    this.AddContent=function (sNA) {
            this.VoteContent["_"+this.VoteCounter]=sNA;
            this.VoteCounter++;
    }
    
    /*评分等级内容*/
    this.VoteScoreContent=function (sID) {
            var VoteContent=this.VoteContent["_"+sID];
            //if (VoteContent=="undefined" || VoteContent==null) VoteContent="Not defined!!";
            return VoteContent;
    }
    
    /*创建评分星星*/
    this.CreateVote=function (MaxStar,DefaultStar,gradeImgId,gradeTextId) {
        var i=1,j=1;
        var VoteImgHTML = "<li>模块评价:</li>";
        this.VoteMaxStar=MaxStar;
        for (i=1;i<=MaxStar;i++) {
                VoteImgHTML += "<li><img id=\"_GradeVoteID"+i+"\" onClick=\"showGradeBorder('"+i+"')\" src=\""+(j<=DefaultStar ? this.GradeVoteImage1 : this.GradeVoteImage2)+"\" width=\"17\" height=\"16\" border=\"0\" onMouseOver=\"WindowVote.HitVote('"+i+"','"+gradeTextId+"');\" onMouseOut=\"resetGrade('"+gradeImgId+"','"+gradeTextId+"')\" style=\"cursor:hand\"></li>";
                j++;
        }
        VoteImgHTML += "<li><span id=\"GradeVoteText\">"+(this.VoteScoreContent(DefaultStar)==undefined?"":this.VoteScoreContent(DefaultStar))+"</span></li>";
        if (document.getElementById(gradeImgId)!=null) {
                document.getElementById(gradeImgId).innerHTML=VoteImgHTML;
        }
        else {
                alert("Object not found!!");
        }
    }
    
    /*鼠标放到星星上*/
    this.HitVote=function(sID,gradeTextId){
            var i=1;
            for(i=1;i<=sID;i++){
                document.getElementById("_GradeVoteID"+i).src=this.GradeVoteImage1;
            }
            document.getElementById(gradeTextId).innerHTML=this.VoteScoreContent(sID);
            sID++;
            for(i=sID;i<=this.VoteMaxStar;i++){
                document.getElementById("_GradeVoteID"+i).src=this.GradeVoteImage2;
            }
    }
    
  this.AddContent("很不满意(1分)");
	this.AddContent("不满意(2分)");
	this.AddContent("一般(3分)");
	this.AddContent("满意(4分)");
	this.AddContent("很满意(5分)");
}

function showGradeBorder(grade){
	var opCode = document.getElementById("opCode").value;
	var opName = document.getElementById("opName").value;
	var url = globalPathRoot+"/npage/public/moduleGradeInfo.jsp?opCode="+opCode+"&grade="+grade+"&opName="+opName;
	openDivWin(url,"模块评价",600,340);
}

function doProcess_ModuleGrade(data) 
{
	document.getElementById("Waiting").innerHTML= data;
}

function getInitGrade()
{
	var gradeImgId ="evaluate";
		if (document.getElementById(gradeImgId)!=null) {
			var VoteImgHTML = "<li onClick=\"getInitGrade1()\" >模块评价:</li>";
			 VoteImgHTML += "<li><img onClick=\"getInitGrade1()\"  src=\""+WindowVote.GradeVoteImage1+"\" width=\"17\" height=\"16\" border=\"0\"    style=\"cursor:hand\"></li>";
			 VoteImgHTML += "<li><img onClick=\"getInitGrade1()\"  src=\""+WindowVote.GradeVoteImage1+"\" width=\"17\" height=\"16\" border=\"0\"    style=\"cursor:hand\"></li>";
			 VoteImgHTML += "<li><img onClick=\"getInitGrade1()\"  src=\""+WindowVote.GradeVoteImage1+"\" width=\"17\" height=\"16\" border=\"0\"    style=\"cursor:hand\"></li>";
			 VoteImgHTML += "<li><img onClick=\"getInitGrade1()\"  src=\""+WindowVote.GradeVoteImage1+"\" width=\"17\" height=\"16\" border=\"0\"    style=\"cursor:hand\"></li>";
			 VoteImgHTML += "<li><img onClick=\"getInitGrade1()\"  src=\""+WindowVote.GradeVoteImage1+"\" width=\"17\" height=\"16\" border=\"0\"    style=\"cursor:hand\"></li>";
          document.getElementById(gradeImgId).innerHTML=VoteImgHTML;
          gradeImgId = null;
          VoteImgHTML= null;
          
		}
}


function getInitGrade1(){
	
	var evaluate = document.getElementById("evaluate");
	if(!evaluate){
		return
	}
	var opCode = document.getElementById("opCode").value;
	var chkPacket = new AJAXPacket(globalPathRoot+"/npage/public/moduleGradeAjax.jsp","正在获取信息,请稍后...");
	chkPacket.data.add("opCode",opCode);
	core.ajax.sendPacket(chkPacket,doProcess_getInitGrade);
	chkPacket =null;
	
}

function doProcess_getInitGrade(chkPacket){
	var initGrade = chkPacket.data.findValueByName("initGrade");
	var opCode = chkPacket.data.findValueByName("opCode");
	document.getElementById("initGrade").value = initGrade;
	WindowVote.CreateVote(5,initGrade,"evaluate","GradeVoteText");
}

function resetGrade(gradeImgId,gradeTextId){
	var initGrade = document.getElementById("initGrade").value;
	WindowVote.CreateVote(5,initGrade,gradeImgId,gradeTextId);
}