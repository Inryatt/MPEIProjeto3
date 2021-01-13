function movieids = set_movies(userid,udata)
    tmp = udata(:,1)== userid;  % tmp = linhas em que o userid é o dado
    uinfo=udata(tmp,:);         % uinfo = matriz com os userids = userid e os movies desse userid
    movieids = unique(uinfo(:,2));
end