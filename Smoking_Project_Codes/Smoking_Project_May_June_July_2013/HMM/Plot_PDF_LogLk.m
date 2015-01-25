function[Ldgnd1] = Plot_PDF_LogLk(LoglikStruct)

Ind = find(LoglikStruct == -Inf);

LoglikStruct(Ind) = [];

if(isempty(LoglikStruct))
else
    p = gkde0(LoglikStruct);
end

Ldgnd1 = plot(p.x,p.f,'linewidth',2,'Color',[rand rand rand]);


end