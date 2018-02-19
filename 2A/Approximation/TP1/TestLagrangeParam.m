[X,Y] = saisi_points();
T = caractTime(X,Y);
u1 = min(T(1,:)):0.001:max(T(1,:));
u2 = min(T(2,:)):0.001:max(T(2,:));
u3 = min(T(3,:)):0.001:max(T(3,:));
u4 = min(T(4,:)):0.001:max(T(4,:));

[V1,S1] = LagrangeParametrique(u1,T(1,:),X,Y);
[V2,S2] = LagrangeParametrique(u2,T(2,:),X,Y);
[V3,S3] = LagrangeParametrique(u3,T(3,:),X,Y);
[V4,S4] = LagrangeParametrique(u4,T(4,:),X,Y);

subplot(2,2,1)
axis([0 1 0 1])
hold on
plot(V1,S1);
plot(X,Y,'*');
title("Uniforme");
hold off

subplot(2,2,2)
axis([0 1 0 1])
hold on
plot(V2,S2);
plot(X,Y,'*');
title("Distance");
hold off

subplot(2,2,3)
axis([0 1 0 1])
hold on
plot(V3,S3);
plot(X,Y,'*');
title("SQRT Distance");
hold off

subplot(2,2,4)
axis([0 1 0 1])
hold on
plot(V4,S4);
plot(X,Y,'*');
title("Tchebychev");
hold off