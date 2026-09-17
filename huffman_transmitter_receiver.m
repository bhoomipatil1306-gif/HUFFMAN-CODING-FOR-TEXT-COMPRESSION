function huffman_transmitter_receiver

f=uifigure('Name','Huffman Coding','Position',[50 30 1200 750]);

uilabel(f,'Text','HUFFMAN TEXT COMPRESSION','FontSize',24,...
    'FontWeight','bold','HorizontalAlignment','center',...
    'Position',[350 710 500 30]);

% ================= TRANSMITTER =================

tx=uipanel(f,'Title','TRANSMITTER','FontSize',16,...
    'FontWeight','bold','Position',[20 25 570 660]);

uilabel(tx,'Text','Original Text','FontSize',13,...
    'FontWeight','bold','Position',[20 595 150 25]);

in=uitextarea(tx,'Position',[20 450 530 140]);

uibutton(tx,'Text','COMPRESS','FontSize',13,'FontWeight','bold',...
    'Position',[210 405 140 40],'ButtonPushedFcn',@compress);

uilabel(tx,'Text','Huffman Codes','FontSize',13,...
    'FontWeight','bold','Position',[20 370 180 25]);

tbl=uitable(tx,'Position',[20 200 530 170],...
    'ColumnName',{'Character','Frequency','Probability','Huffman Code'},...
    'ColumnWidth',{110 100 120 170});


% ================= RECEIVER =================

rx=uipanel(f,'Title','RECEIVER','FontSize',16,...
    'FontWeight','bold','Position',[610 25 570 660]);

uilabel(rx,'Text','Received Compressed Binary','FontSize',13,...
    'FontWeight','bold','Position',[20 595 250 25]);

received=uitextarea(rx,'Position',[20 455 530 135],'Editable','off');

uilabel(rx,'Text','Decompressed Text','FontSize',13,...
    'FontWeight','bold','Position',[20 425 200 25]);

output=uitextarea(rx,'Position',[20 300 530 115],'Editable','off');

uibutton(rx,'Text','DECOMPRESS','FontSize',13,'FontWeight','bold',...
    'Position',[210 250 140 40],'ButtonPushedFcn',@decompress);

uilabel(rx,'Text','COMPRESSION INFORMATION','FontSize',13,...
    'FontWeight','bold','Position',[20 215 250 25]);

i1=uilabel(rx,'Text','Original Size: -','Position',[20 185 500 25]);
i2=uilabel(rx,'Text','Compressed Size: -','Position',[20 158 500 25]);
i3=uilabel(rx,'Text','Entropy: -','Position',[20 131 500 25]);
i4=uilabel(rx,'Text','Average Code Length: -','Position',[20 104 500 25]);
i5=uilabel(rx,'Text','Efficiency: -','Position',[20 77 500 25]);
i6=uilabel(rx,'Text','Space Saved: -','Position',[20 50 500 25]);

status=uilabel(rx,'Text','Status: Waiting for data...',...
    'FontWeight','bold','Position',[20 20 520 25]);


% ================= VARIABLES =================

codes=containers.Map('KeyType','char','ValueType','char');
reverse=containers.Map('KeyType','char','ValueType','char');
bits='';
original='';


% ================= COMPRESS =================

function compress(~,~)

    text=strjoin(in.Value,newline);

    if isempty(text)
        uialert(f,'Enter some text.','Error'); return
    end

    original=text;
    chars=unique(text);
    freq=arrayfun(@(c)sum(text==c),chars);

    nodes=cell(1,length(chars));

    for k=1:length(chars)
        nodes{k}=struct('c',chars(k),'n',freq(k),'l',[],'r',[]);
    end

    if length(nodes)==1
        root=nodes{1};
        codes(chars(1))='0';
    else
        while length(nodes)>1
            [~,p]=sort(cellfun(@(x)x.n,nodes));
            nodes=nodes(p);
            a=nodes{1}; b=nodes{2};
            nodes(1:2)=[];
            nodes{end+1}=struct('c',char(0),'n',a.n+b.n,...
                'l',a,'r',b);
        end

        root=nodes{1};
        makeCode(root,'');
    end

    bits='';
    for k=1:length(text)
        bits=[bits codes(text(k))];
    end

    received.Value=wrap(bits,70);

    data=cell(length(chars),4);

    for k=1:length(chars)

        c=chars(k);
        code=codes(c);
        reverse(code)=c;

        if c==' '
            d='[SPACE]';
        elseif c==newline
            d='[NEWLINE]';
        elseif c==char(9)
            d='[TAB]';
        else
            d=c;
        end

        p=freq(k)/length(text);
        data(k,:)={d,freq(k),sprintf('%.4f',p),code};

    end

    tbl.Data=data;

    p=freq/length(text);
    H=-sum(p.*log2(p));

    L=0;
    for k=1:length(chars)
        L=L+p(k)*length(codes(chars(k)));
    end

    originalBits=length(text)*8;
    compressedBits=length(bits);
    efficiency=H/L*100;
    saved=(1-compressedBits/originalBits)*100;

    i1.Text=sprintf('Original Size: %d bits',originalBits);
    i2.Text=sprintf('Compressed Size: %d bits',compressedBits);
    i3.Text=sprintf('Entropy: %.4f bits/character',H);
    i4.Text=sprintf('Average Code Length: %.4f bits/character',L);
    i5.Text=sprintf('Efficiency: %.2f%%',efficiency);
    i6.Text=sprintf('Space Saved: %.2f%%',saved);

    status.Text='Status: Compression completed successfully.';

end


% ================= HUFFMAN CODE =================

function makeCode(node,s)

    if isempty(node.l) && isempty(node.r)
        if isempty(s), s='0'; end
        codes(node.c)=s;
        return
    end

    if ~isempty(node.l)
        makeCode(node.l,[s '0']);
    end

    if ~isempty(node.r)
        makeCode(node.r,[s '1']);
    end

end


% ================= DECOMPRESS =================

function decompress(~,~)

    if isempty(bits)
        uialert(f,'Compress the text first.','Error');
        return
    end

    code='';
    decoded='';

    for k=1:length(bits)

        code=[code bits(k)];

        if isKey(reverse,code)
            decoded=[decoded reverse(code)];
            code='';
        end

    end

    output.Value=wrap(decoded,70);

    if strcmp(decoded,original)
        status.Text='Status: SUCCESS - Original text restored.';
    else
        status.Text='Status: ERROR - Verification failed.';
    end

end


% ================= WRAP TEXT =================

function x=wrap(s,n)

    if isempty(s)
        x={''}; return
    end
    x=cell(1,ceil(length(s)/n));
    for k=1:length(x)
        a=(k-1)*n+1;
        b=min(k*n,length(s));
        x{k}=s(a:b);
    end
end
end