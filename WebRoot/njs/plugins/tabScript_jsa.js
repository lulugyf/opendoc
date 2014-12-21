/*
 * Company:     si-tech;
 * Department:  CRM_RD
 * Author:      yangrq
 */

var g_imgTabWay = globalPathRoot + "/nresources/default/images/tabimages/";
function g(objectId) {
    if (document.getElementById && document.getElementById(objectId)) {
        return document.getElementById(objectId)
    } else if (document.all && document.all[objectId]) {
        return document.all[objectId]
    } else if (document.layers && document.layers[objectId]) {
        return document.layers[objectId]
    } else {
        return false
    }
}
function HoverTab() {
    var $ = g("tabtag").getElementsByTagName("li"),
    A = g("contentArea").getElementsByTagName("dt");
    for (var _ = 0; _ < $.length; _++)(function(_) {
        $[_].onclick = function() {
            for (var H = 0; H < $.length; H++) {
                $[H].className = "";
                A[H].className = ""
            }
            $[_].className = "current";
            A[_].className = "on";
            if ($[_].name) activateTab($[_].id);
            var B = 0,
            F = g("tab"),
            E = g("tabset"),
            D = E.clientWidth,
            G = F.style.left.substr(0, F.style.left.length - 2);
            for (var C = 0; C < _; C++) B += $[C].clientWidth + 2;
            if ( - G > B) F.style.left = -B + "px";
            if (( - G + D) < (B + $[_].clientWidth + 50)) F.style.left = -(B - D + $[_].clientWidth + 50) + "px"
        }
    })(_)
}
function addTab(A, B, $, _) {
    initTab();
    if (isNewTab(B)) addNewTab(A, B, $, _)
}
function addNewTab(G, A, F, K) {
    initTab();
    var $ = g("tabtag"),
    J = document.createElement("li");
    J.className = "current";
    J.setAttribute("id", A);
    J.name = G;
    if (G) activateTab(J.id);
    J.oncontextmenu = function() {
        var C = document.createElement("div");
        C.setAttribute("id", "ball");
        var oiframe = document.createElement("iframe");
        var B = document.createElement("div");
        B.setAttribute("id", "colseMe");
        var _ = document.createElement("div");
        _.setAttribute("id", "colseOther");
        var _ALL = document.createElement("div");
        _ALL.setAttribute("id", "colseAll");
        
        uif.mxResources.add(globalPathRoot+'/njs/resources/uif');
				
        colseMeTxt = document.createTextNode(uif.mxResources.get('closeMe','closeMe'));
        colseOtherTxt = document.createTextNode(uif.mxResources.get('closeOther','closeOther'));
        colseAllTxt = document.createTextNode(uif.mxResources.get('closeAll','closeAll'));
        var D = document.createElement("div");
        D.setAttribute("id", "commonUse");
        _txt = document.createTextNode(uif.mxResources.get('commonUse','commonUse'));
        var E = document.createElement("div");
        E.setAttribute("id", "callHelp");
        var A = document.createTextNode(uif.mxResources.get('callHelp','callHelp')),
        F = document.createElement("div");
        F.setAttribute("id", "comment");
        var $ = document.createTextNode(uif.mxResources.get('comment','comment'));
        B.onmouseover = function() {
            B.className = "curmouse"
        };
        B.onmouseout = function() {
            B.className = ""
        };
        B.onclick = function(A) {
            var B = arguments[0] || window.event,
            C = B.srcElement || B.target,
            _ = C.parentNode.parentNode,
            $ = _.id;
            removeTab($)
        };
        _.onmouseover = function() {
            _.className = "curmouse"
        };
        _.onmouseout = function() {
            _.className = ""
        };
        _.onclick = function() {
            var A = arguments[0] || window.event,
            _ = A.srcElement || A.target,
            B = _.parentNode.parentNode,
            $ = B.id;
            delOtherTab($)
        };
        _ALL.onmouseover = function() {
            _ALL.className = "curmouse"
        };
        _ALL.onmouseout = function() {
            _ALL.className = ""
        };
        _ALL.onclick = function() {
            closeAllTag()
        };
        D.onmouseover = function() {
            D.className = "curmouse"
        };
        D.onmouseout = function() {
            D.className = ""
        };
        D.onclick = function() {
            var A = arguments[0] || window.event,
            _ = A.srcElement || A.target,
            B = _.parentNode.parentNode,
            $ = B.id;
            if (G) addFavfunc($);
            else parent.addFavfunc($)
        };
        E.onmouseover = function() {
            E.className = "curmouse"
        };
        E.onmouseout = function() {
            E.className = ""
        };
        E.onclick = function() {
            var A = arguments[0] || window.event,
            _ = A.srcElement || A.target,
            B = _.parentNode.parentNode,
            $ = B.id;
            if (G) callHelp($);
            else parent.callHelp($)
        };
        F.onmouseover = function() {
            F.className = "curmouse"
        };
        F.onmouseout = function() {
            F.className = ""
        };
        F.onclick = function() {
            var A = arguments[0] || window.event,
            _ = A.srcElement || A.target,
            B = _.parentNode.parentNode,
            $ = B.id;
            var tabName = "";
            if (B.childNodes) {
                tabName = B.firstChild.innerHTML.substr(0, B.firstChild.innerHTML.indexOf("<"))
            }
            if (G) comment($, tabName);
            else parent.comment($, tabName)
        };
        B.appendChild(colseMeTxt);
        _.appendChild(colseOtherTxt);
        _ALL.appendChild(colseAllTxt);
        D.appendChild(_txt);
        E.appendChild(A);
        F.appendChild($);
        C.appendChild(oiframe);
        C.appendChild(B);
        C.appendChild(_);
        C.appendChild(_ALL);
        C.appendChild(D);
        C.appendChild(E);
        C.appendChild(F);
        J.appendChild(C);
        oiframe.style.height = C.offsetHeight + "px";
        
        C.onmouseleave = function() {
            if (document.getElementById("ball")) {
                B.removeChild(colseMeTxt);
                _.removeChild(colseOtherTxt);
                _ALL.removeChild(colseAllTxt);
                D.removeChild(_txt);
                E.removeChild(A);
                F.removeChild($);
                C.removeChild(B);
                C.removeChild(_);
                C.removeChild(_ALL);
                C.removeChild(D);
                C.removeChild(E);
                C.removeChild(F);
                C.removeChild(oiframe);
                J.removeChild(C);
                if(document.all)CollectGarbage()
            }
        };
        J.onmouseleave = function() {
            if (document.getElementById("ball")) {
                B.removeChild(colseMeTxt);
                _.removeChild(colseOtherTxt);
                _ALL.removeChild(colseAllTxt);
                D.removeChild(_txt);
                E.removeChild(A);
                F.removeChild($);
                C.removeChild(B);
                C.removeChild(_);
                C.removeChild(_ALL);
                C.removeChild(D);
                C.removeChild(E);
                C.removeChild(F);
                C.removeChild(oiframe);
                J.removeChild(C);
                if(document.all)CollectGarbage()
            }
        };
        
        return false
    };
    var H = document.createElement("span");
    titleTxt = document.createTextNode(F);
    var C = document.createElement("img");
    C.className = "";
    C.setAttribute("src", g_imgTabWay + "icon_close_off.gif");
    C.onmouseover = function() {
        C.setAttribute("src", g_imgTabWay + "icon_close02_on.gif")
    };
    C.onmouseout = function() {
        C.setAttribute("src", g_imgTabWay + "icon_close_off.gif")
    };
    C.onclick = function(C) {
        var _ = arguments[0] || window.event,
        $ = _.srcElement || _.target,
        A = $.parentNode.parentNode,
        B = A.id;
        removeTab(B)
    };
    H.appendChild(titleTxt);
    H.appendChild(C);
    J.appendChild(H);
    $.appendChild(J);
    var I = g("contentArea"),
    E = document.createElement("dt");
    E.className = "on";
    var B = document.createElement("iframe");
    if (G) {
        g_parentRig = g("workPanel");
        g_parentRigHeight = g_parentRig.clientHeight;
        var D = "iframe" + A;
        B.setAttribute("id", D);
        var _ = (g_parentRigHeight - 28 - 27) + "px"
    } else {
        g_parentRig = parent.g("workPanel");
        g_parentRigHeight = g_parentRig.clientHeight;
        D = "iframe" + A;
        B.setAttribute("id", D);
        var _ = (g_parentRigHeight - 70 - 27) + "px"
    }
    B.setAttribute("align", "left");
    B.setAttribute("frameBorder", "no");
    B.setAttribute("id", "iframe" + A);
    B.setAttribute("crolling", "yes");
    B.setAttribute("width", "100%");
    B.setAttribute("height", _);
    B.setAttribute("scrolling", "auto");
    E.appendChild(B);
    I.appendChild(E);
    setTimeout(function() {
        B.src = K;
    },
    0);
    HoverTab();
    isOverstep()
}
function initTab() {
    var $ = g("tabtag").getElementsByTagName("li"),
    A = g("contentArea").getElementsByTagName("dt");
    for (var _ = 0; _ < $.length; _++) {
        $[_].className = "";
        A[_].className = ""
    }
}
function isNewTab(J) {
    var K = true,
    B = g("imgRight"),
    E = g("imgLeft"),
    F = 0,
    _ = g("tab"),
    C = _.style.left.substr(0, _.style.left.length - 2),
    I = g("tabset"),
    A = I.clientWidth,
    D = g("tabtag").getElementsByTagName("li"),
    G = g("contentArea").getElementsByTagName("dt");
    for (var $ = 0; $ < D.length; $++) {
        var H = D[$].getAttribute("id");
        F += D[$].clientWidth + 2;
        if (D[$].id == J) {
            if ( - C > F - D[$].clientWidth + 2) _.style.left = -F + D[$].clientWidth + 2 + "px";
            if ((F) > ( - C + A)) _.style.left = -(F - A + 50) + "px";
            D[$].className = "current";
            G[$].className = "on";
            if (D[$].name) activateTab(D[$].id);
            K = false;
            break
        }
    }
    return K
}
function removeTab(H) {
    var A = g("imgRight"),
    D = g("imgLeft"),
    E = 0,
    _ = g("tab"),
    B = parseInt(_.style.left.substr(0, _.style.left.length - 2)),
    J = g("tabset"),
    I = J.clientWidth,
    C = g("tabtag").getElementsByTagName("li");
    for (var G = 0; G < C.length; G++) E += C[G].clientWidth + 2;
    var F = g("contentArea").getElementsByTagName("dt");
    for (var $ = 0; $ < C.length; $++) if (C[$].id == H) {
        if (E > ( - B + I)) {
            _.style.paddingLeft = 24 + "px";
            _.style.left = B;
            A.style.dispaly = "block";
            D.style.dispaly = "block";
            D.setAttribute("src", g_imgTabWay + "btn_left_on.gif");
            A.setAttribute("src", g_imgTabWay + "btn_right_on.gif")
        } else if (( - B > C[$].clientWidth) && E > I) {
            _.style.paddingLeft = 24 + "px";
            _.style.left = B + C[$].clientWidth + 2 + "px";
            A.style.dispaly = "block";
            D.style.dispaly = "block";
            D.setAttribute("src", g_imgTabWay + "btn_left_on.gif");
            A.setAttribute("src", g_imgTabWay + "btn_right.gif")
        } else {
            _.style.paddingLeft = 0 + "px";
            _.style.left = 0 + "px";
            D.style.display = "none";
            A.style.display = "none";
            D.setAttribute("src", g_imgTabWay + "btn_left.gif");
            A.setAttribute("src", g_imgTabWay + "btn_right.gif")
        }
        if (C[$].className == "current") {
            C[$ - 1].className = "current";
            F[$ - 1].className = "on";
            _.style.left = 0 + "px";
            D.setAttribute("src", g_imgTabWay + "btn_left.gif");
            A.setAttribute("src", g_imgTabWay + "btn_right_on.gif");
            if (C[$ - 1].name) activateTab(C[$ - 1].id)
        }
        C[$].onclick= function() {}; 
        if (C[$].name) destroyTab(C[$].id);
        break
    }
    iframe = F[$].firstChild;
    iframe.src = "_blank";
    F[$].removeChild(iframe);
    a = C[$].firstChild;
    C[$].removeChild(a);
    tabparent = C[$].parentNode;
    contparent = F[$].parentNode;
    tabparent.removeChild(C[$]);
    contparent.removeChild(F[$]);
    if(document.all)CollectGarbage();
    HoverTab();
}
function delOtherTab(F) {
    var $ = g("imgRight"),
    C = g("imgLeft"),
    A = g("tabtag").getElementsByTagName("li"),
    H = g("contentArea").getElementsByTagName("dt"),
    _ = A.length;
    for (var G = _ - 1; G > 0; G--) {
        if (A[G].id == F || G == 0) continue;
        if (A[G].name) destroyTab(A[G].id);
        iframe = H[G].firstChild;
        iframe.src = "_blank";
        H[G].removeChild(iframe);
        a = A[G].firstChild;
        A[G].removeChild(a);
        tabparent = A[G].parentNode;
        contparent = H[G].parentNode;
        tabparent.removeChild(A[G]);
        contparent.removeChild(H[G])
    }
    var D = g("tabtag").getElementsByTagName("li"),
    B = g("contentArea").getElementsByTagName("dt");
    D[0].className = "current";
    B[0].className = "on";
    if (D[0].name) activateTab(D[0].id);
    var E = g("tab");
    E.style.paddingLeft = 0 + "px";
    E.style.left = 0 + "px";
    C.style.display = "none";
    $.style.display = "none";
    HoverTab()
}
function closeAllTag() {
    var $ = g("imgRight"),
    C = g("imgLeft"),
    A = g("tabtag").getElementsByTagName("li"),
    H = g("contentArea").getElementsByTagName("dt"),
    _ = A.length;
    for (var G = _ - 1; G > 0; G--) {
        if (G == 0) continue;
        if (A[G].name) destroyTab(A[G].id);
        iframe = H[G].firstChild;
        iframe.src = "_blank";
        H[G].removeChild(iframe);
        a = A[G].firstChild;
        A[G].removeChild(a);
        A[G].onclick= function() {}; 
        tabparent = A[G].parentNode;
        contparent = H[G].parentNode;
        tabparent.removeChild(A[G]);
        contparent.removeChild(H[G])
    }
    var D = g("tabtag").getElementsByTagName("li"),
    B = g("contentArea").getElementsByTagName("dt");
    D[0].className = "current";
    B[0].className = "on";
    if (D[0].name) activateTab(D[0].id);
    var E = g("tab");
    E.style.paddingLeft = 0 + "px";
    E.style.left = 0 + "px";
    C.style.display = "none";
    $.style.display = "none";
    HoverTab()
}
function isOverstep() {
    var D = g("imgRight"),
    E = g("imgLeft"),
    _ = g("tabtag").getElementsByTagName("li"),
    A = 0;
    for (var $ = 0; $ < _.length; $++) A += _[$].clientWidth + 2;
    var C = g("tabset"),
    B = C.clientWidth;
    if (A > B) {
        g("tab").style.paddingLeft = 24 + "px";
        g("tab").style.left = ( - (A - B + 50)) + "px";
        E.style.display = "block";
        E.setAttribute("src", g_imgTabWay + "btn_left_on.gif");
        D.style.display = "block";
        D.setAttribute("src", g_imgTabWay + "btn_right.gif")
    }
}
var g_leftPosition = 0;
function BtnMoveLeft() {
    var $ = g("imgRight"),
    C = g("imgLeft"),
    E = g("tabtag").getElementsByTagName("li"),
    D = 0;
    for (var G = 0; G < E.length; G++) D += E[G].clientWidth + 2;
    var A = g("tabset"),
    B = A.clientWidth,
    _ = g("tab"),
    H = parseInt(_.style.left.substr(0, _.style.left.length - 2));
    if (D < B) {
        _.style.paddingLeft = 0 + "px";
        $.style.display = "none";
        C.style.display = "none";
        _.style.left = 0 + "px"
    } else if (B < D && ( - H) > 80) {
        _.style.paddingLeft = 24 + "px";
        $.style.display = "block";
        C.style.display = "block";
        var F;
        if (g_leftPosition < 30) {
            g_leftPosition++;
            F = setTimeout(function() {
                _.style.left = H + 5 + "px";
                BtnMoveLeft()
            },
            300 / 100)
        } else {
            g_leftPosition = 0;
            clearTimeout(F)
        }
        C.setAttribute("src", g_imgTabWay + "btn_left_on.gif");
        $.setAttribute("src", g_imgTabWay + "btn_right_on.gif")
    } else {
        _.style.left = 0 + "px";
        C.setAttribute("src", g_imgTabWay + "btn_left.gif")
    }
}
function BtnMoveRight(B) {
    var I = g("imgRight"),
    _ = g("imgLeft"),
    F = g("tabtag").getElementsByTagName("li"),
    $ = 0;
    for (var D = 0; D < F.length; D++) $ += F[D].clientWidth + 2;
    var G = g("tabset"),
    H = G.clientWidth,
    A = g("tab"),
    C = parseInt(A.style.left.substr(0, A.style.left.length - 2));
    if ($ < H) {
        A.style.paddingLeft = 0 + "px";
        A.style.left = 0 + "px";
        _.style.display = "none";
        I.style.display = "none"
    } else if (( - C + H) < $) {
        A.style.paddingLeft = 24 + "px";
        I.style.display = "block";
        _.style.display = "block";
        var E;
        if (g_leftPosition < 30) {
            g_leftPosition++;
            E = setTimeout(function() {
                A.style.left = C - 5 + "px";
                BtnMoveRight(B)
            },
            300 / 100)
        } else {
            g_leftPosition = 0;
            clearTimeout(E)
        }
        _.setAttribute("src", g_imgTabWay + "btn_left_on.gif");
        I.setAttribute("src", g_imgTabWay + "btn_right_on.gif")
    } else {
        A.style.left = -($ - H + 50);
        I.setAttribute("src", g_imgTabWay + "btn_right.gif")
    }
}