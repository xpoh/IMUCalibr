n1=590000;
n2=length(data.gyro);

data.acc = data.acc(n1:n2,:);
data.accCount = data.accCount(n1:n2,:);
data.count =data.count(n1:n2,:);
data.gyro = data.gyro(n1:n2,:);
data.mux = data.mux;
data.period = data.period(n1:n2,:);
data.sensStatus = data.sensStatus(n1:n2,:);