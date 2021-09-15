<nav class="sidenav navbar navbar-vertical fixed-left navbar-expand-xs navbar-light bg-white" id="sidenav-main">
            <div class="scrollbar-inner">
                <div class="sidenav-header d-flex align-items-center">
                    <a class="navbar-brand" >
                        <img src="../assets/icon/onges_home.png" class="navbar-brand-img" alt="...">
                    </a>
                    <div class="ml-auto">
                        <div class="sidenav-toggler d-none d-xl-block" data-action="sidenav-unpin" data-target="#sidenav-main">
                            <div class="sidenav-toggler-inner">
                                <i class="sidenav-toggler-line"></i>
                                <i class="sidenav-toggler-line"></i>
                                <i class="sidenav-toggler-line"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="navbar-inner">
                    <div class="collapse navbar-collapse" id="sidenav-collapse-main">
                        <ul class="navbar-nav">
                        <%
                            try {
                                if(u.getProfileSchool().getProfile() == null){
                                    for (Menu mc : u.getProfile().getMenus()) {
                                        if(mc.isStatus() == true){
                                           if(url.toLowerCase().contains(mc.getLink().toLowerCase())){
                        %>
                            <li class="nav-item">
                                <a class="nav-link active" href="<%=mc.getLink() %>">
                                    <i class="<%=mc.getIcon() %> <%=mc.getColor() %>"></i>
                                    <span class='nav-link-text'><%=mc.getTitle() %></span>
                                </a>
                            </li>
                            <%
                                        }else{%>
                            <li class="nav-item">
                                <a class="nav-link" href="<%=mc.getLink() %>">
                                    <i class="<%=mc.getIcon() %> <%=mc.getColor() %>"></i>
                                    <span class='nav-link-text'><%=mc.getTitle() %></span>
                                </a>
                            </li>
                            <%
                                            } 
                                        }
                                    }
                                } else {
                                    for (Menu mc : u.getProfileSchool().getMenus()) {
                                        if(mc.isStatus() == true){
                                           if(url.toLowerCase().contains(mc.getLink().toLowerCase())){
                        %>
                            <li class="nav-item">
                                <a class="nav-link active" href="<%=mc.getLink() %>">
                                    <i class="<%=mc.getIcon() %> <%=mc.getColor() %>"></i>
                                    <span class='nav-link-text'><%=mc.getTitle() %></span>
                                </a>
                            </li>
                            <%
                                        }else{%>
                            <li class="nav-item">
                                <a class="nav-link" href="<%=mc.getLink() %>">
                                    <i class="<%=mc.getIcon() %> <%=mc.getColor() %>"></i>
                                    <span class='nav-link-text'><%=mc.getTitle() %></span>
                                </a>
                            </li>
                            <%
                                            } 
                                        }
                                    }
                                }
                            } catch (Exception e) {
                                response.sendRedirect(link);
                            }
                        %>
                        </ul>
                        <hr class="my-3">
                    </div>
                </div>
            </div>
        </nav>