I=imread('rice.png');
I0=myimmove(I,100,30);
subplot(1,2,1);imshow(I);title('Ô­Í¼');
subplot(1,2,2);imshow(I0/256),title('Æ½ÒÆ');
%imshow
%imshowµÄbug