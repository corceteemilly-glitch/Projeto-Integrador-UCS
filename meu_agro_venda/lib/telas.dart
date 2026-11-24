import 'package:flutter/material.dart';
import 'banco.dart';

typedef Registro = Map<String,Object?>;
final banco = Banco.instancia;
String dinheiro(num n) => 'R\$ ${n.toStringAsFixed(2).replaceAll('.', ',')}';
String dataIso(DateTime d) => d.toIso8601String().substring(0,10);
String dataBr(Object? d) => (d?.toString() ?? '').split('-').reversed.join('/');
double? numero(String s) => double.tryParse(s.trim().replaceAll(',', '.'));
void aviso(BuildContext c, Object e) => ScaffoldMessenger.of(c).showSnackBar(SnackBar(content: Text('$e')));
Future<bool> confirmar(BuildContext c) async => await showDialog<bool>(context:c,builder:(c)=>AlertDialog(title:const Text('Excluir registro?'),content:const Text('Esta ação não pode ser desfeita.'),actions:[TextButton(onPressed:()=>Navigator.pop(c,false),child:const Text('Cancelar')),FilledButton(onPressed:()=>Navigator.pop(c,true),child:const Text('Excluir'))])) ?? false;

class Painel extends StatefulWidget {
  final int usuarioId;
  const Painel({super.key,required this.usuarioId});
  @override State<Painel> createState()=>_PainelState();
}
class _PainelState extends State<Painel> {
  int aba=0;
  int revisao=0;
  void atualizar()=>setState(()=>revisao++);
  Future<void> novaVenda() async { await Navigator.push(context,MaterialPageRoute(builder:(_)=>FormVenda(usuarioId:widget.usuarioId))); if(mounted) atualizar(); }
  @override Widget build(BuildContext context) {
    final telas=[Dashboard(key:ValueKey('d$revisao'),novaVenda:novaVenda),Historico(key:ValueKey('v$revisao'),usuarioId:widget.usuarioId),Cadastros(key:ValueKey('c$revisao'),tabela:'cliente'),Cadastros(key:ValueKey('p$revisao'),tabela:'produto')];
    return Scaffold(appBar:AppBar(title:Text(['AgroVende • Início','Histórico de vendas','Clientes','Produtos'][aba]),actions:[IconButton(tooltip:'Sair',onPressed:()=>Navigator.pop(context),icon:const Icon(Icons.logout))]),body: telas[aba],bottomNavigationBar:NavigationBar(selectedIndex:aba,onDestinationSelected:(i)=>setState(()=>aba=i),destinations:const [NavigationDestination(icon:Icon(Icons.home_outlined),label:'Início'),NavigationDestination(icon:Icon(Icons.receipt_long),label:'Vendas'),NavigationDestination(icon:Icon(Icons.people_outline),label:'Clientes'),NavigationDestination(icon:Icon(Icons.inventory_2_outlined),label:'Produtos')]));
  }
}
class Dashboard extends StatelessWidget {
  final VoidCallback novaVenda;
  const Dashboard({super.key,required this.novaVenda});
  @override Widget build(BuildContext context)=>FutureBuilder<List<Registro>>(future:banco.vendas(),builder:(c,s){
    if(s.hasError)return Center(child:Text('Erro: ${s.error}'));
    if(!s.hasData)return const Center(child:CircularProgressIndicator());
    final agora=DateTime.now(); final mes=dataIso(agora).substring(0,7);
    final vendas=s.data!; final atuais=vendas.where((v)=>v['data_venda'].toString().startsWith(mes)).toList();
    final total=atuais.fold<num>(0,(a,v)=>a+(v['valor_total'] as num));
    final itens=atuais.fold<num>(0,(a,v)=>a+(v['quantidade'] as num));
    final meses=<String,double>{}; final produtos=<String,double>{};
    for(var i=5;i>=0;i--){final d=DateTime(agora.year,agora.month-i); meses[dataIso(d).substring(0,7)]=0;}
    for(final v in vendas){final m=v['data_venda'].toString().substring(0,7); if(meses.containsKey(m))meses[m]=meses[m]!+(v['valor_total'] as num).toDouble();}
    for(final v in atuais){final n='${v['produto']} (${v['unidade']})'; produtos[n]=(produtos[n]??0)+(v['quantidade'] as num).toDouble();}
    final ranking=produtos.entries.toList()..sort((a,b)=>b.value.compareTo(a.value));
    return ListView(padding:const EdgeInsets.all(16),children:[Text('Resumo do mês ${mes.substring(5)}/${mes.substring(0,4)}',style:Theme.of(c).textTheme.titleLarge),_indicador('Faturamento',dinheiro(total),Icons.payments_outlined),_indicador('Quantidade vendida (soma)',itens.toStringAsFixed(2),Icons.shopping_basket_outlined),_indicador('Vendas realizadas','${atuais.length}',Icons.receipt_long),FilledButton.icon(onPressed:novaVenda,icon:const Icon(Icons.add),label:const Text('Nova venda')),const SizedBox(height:20),_grafico('Faturamento dos últimos 6 meses',meses,true),_grafico('Produtos mais vendidos no mês',Map.fromEntries(ranking.take(5)),false)]);
  });
  Widget _indicador(String t,String v,IconData i)=>Card(color:const Color(0xfff0f7ef),child:ListTile(leading:Icon(i,color:const Color(0xff006332)),title:Text(t),subtitle:Text(v,style:const TextStyle(fontSize:23,fontWeight:FontWeight.bold))));
  Widget _grafico(String t,Map<String,double> valores,bool moeda){final max=valores.values.fold<double>(0,(a,b)=>a>b?a:b);return Card(child:Padding(padding:const EdgeInsets.all(16),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(t,style:const TextStyle(fontWeight:FontWeight.bold)),if(valores.isEmpty)const Text('Sem vendas registradas'),for(final e in valores.entries)...[const SizedBox(height:10),Text('${e.key}: ${moeda?dinheiro(e.value):e.value.toStringAsFixed(2)}'),LinearProgressIndicator(value:max==0?0:e.value/max,minHeight:9)]])));}
}
class Cadastros extends StatefulWidget {
  final String tabela;
  const Cadastros({super.key,required this.tabela});
  @override State<Cadastros> createState()=>_CadastrosState();
}
class _CadastrosState extends State<Cadastros>{
  String busca=''; late Future<List<Registro>> dados;
  bool get cliente=>widget.tabela=='cliente';
  @override void initState(){super.initState(); dados=banco.listar(widget.tabela);}
  void recarregar()=>setState(() { dados=banco.listar(widget.tabela); });
  Future<void> abrir([Registro? r])async{await Navigator.push(context,MaterialPageRoute(builder:(_)=>FormCadastro(tabela:widget.tabela,registro:r)));if(mounted)recarregar();}
  @override Widget build(BuildContext context)=>Column(children:[Padding(padding:const EdgeInsets.all(16),child:TextField(decoration:const InputDecoration(labelText:'Pesquisar por nome',prefixIcon:Icon(Icons.search),border:OutlineInputBorder()),onChanged:(v)=>setState(()=>busca=v.toLowerCase()))),FilledButton.icon(onPressed:()=>abrir(),icon:const Icon(Icons.add),label:Text(cliente?'Novo cliente':'Novo produto')),Expanded(child:FutureBuilder<List<Registro>>(future:dados,builder:(c,s){if(s.hasError)return Center(child:Text('${s.error}'));if(!s.hasData)return const Center(child:CircularProgressIndicator());final r=s.data!.where((v)=>v['nome'].toString().toLowerCase().contains(busca)).toList();if(r.isEmpty)return const Center(child:Text('Nenhum registro encontrado.'));return ListView.builder(itemCount:r.length,itemBuilder:(c,i){final v=r[i];return Card(child:ListTile(title:Text('${v['nome']}'),subtitle:Text(cliente?'${v['telefone']}':'${dinheiro(v['valor_unitario'] as num)} / ${v['unidade_medida']}'),onTap:()=>abrir(v),trailing:IconButton(icon:const Icon(Icons.delete_outline),onPressed:()async{if(!await confirmar(context))return;try{await banco.excluir(widget.tabela,v['id_${widget.tabela}'] as int);if(mounted)recarregar();}catch(e){if(mounted)aviso(context,'Não foi possível excluir. O registro pode estar vinculado a uma venda.');}})));});}))]);
}
class FormCadastro extends StatefulWidget {
  final String tabela; final Registro? registro;
  const FormCadastro({super.key,required this.tabela,this.registro});
  @override State<FormCadastro> createState()=>_FormCadastroState();
}
class _FormCadastroState extends State<FormCadastro>{
  final chave=GlobalKey<FormState>(); final campos=<String,TextEditingController>{}; bool salvando=false;
  bool get cliente=>widget.tabela=='cliente';
  Map<String,String> get nomes=>cliente?{'nome':'Nome completo','telefone':'Telefone','email':'E-mail (opcional)','endereco':'Endereço (opcional)'}:{'nome':'Nome do produto','descricao':'Descrição (opcional)','valor_unitario':'Valor unitário (R\$)','unidade_medida':'Unidade (kg, un, dúzia...)'};
  @override void initState(){super.initState();for(final k in nomes.keys){campos[k]=TextEditingController(text:widget.registro?[k]?.toString()??'');}}
  @override void dispose(){for(final c in campos.values){c.dispose();}super.dispose();}
  Future<void> salvar()async{if(!chave.currentState!.validate())return;setState(()=>salvando=true);try{final dados=<String,Object?>{for(final e in campos.entries)e.key:e.value.text.trim()};if(!cliente)dados['valor_unitario']=numero(campos['valor_unitario']!.text)!;await banco.salvar(widget.tabela,dados,widget.registro?['id_${widget.tabela}'] as int?);if(mounted)Navigator.pop(context);}catch(e){if(mounted)aviso(context,'Não foi possível salvar: $e');}finally{if(mounted)setState(()=>salvando=false);}}
  @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:Text('${widget.registro==null?'Novo':'Editar'} ${widget.tabela}')),body:Form(key:chave,child:ListView(padding:const EdgeInsets.all(20),children:[for(final e in nomes.entries)Padding(padding:const EdgeInsets.only(bottom:14),child:TextFormField(controller:campos[e.key],keyboardType:e.key=='valor_unitario'?const TextInputType.numberWithOptions(decimal:true):TextInputType.text,decoration:InputDecoration(labelText:e.value,border:const OutlineInputBorder()),validator:(v){if(!e.value.contains('opcional')&&(v??'').trim().isEmpty)return 'Campo obrigatório';if(e.key=='valor_unitario'){final n=numero(v??'');if(n==null||!n.isFinite||n<0)return 'Informe um valor válido';}return null;})),FilledButton(onPressed:salvando?null:salvar,child:const Text('Salvar'))])));
}
class Historico extends StatefulWidget {
  final int usuarioId;
  const Historico({super.key,required this.usuarioId});
  @override State<Historico> createState()=>_HistoricoState();
}
class _HistoricoState extends State<Historico>{
  String busca=''; int periodo=0; late Future<List<Registro>> dados;
  @override void initState(){super.initState();dados=banco.vendas();}
  Future<void> abrir(Widget w)async{await Navigator.push(context,MaterialPageRoute(builder:(_)=>w));if(mounted)setState(() { dados=banco.vendas(); });}
  @override Widget build(BuildContext context)=>Column(children:[Padding(padding:const EdgeInsets.all(12),child:TextField(decoration:const InputDecoration(labelText:'Pesquisar cliente ou produto',prefixIcon:Icon(Icons.search),border:OutlineInputBorder()),onChanged:(v)=>setState(()=>busca=v.toLowerCase()))),Wrap(spacing:8,crossAxisAlignment:WrapCrossAlignment.center,children:[DropdownButton<int>(value:periodo,items:const [DropdownMenuItem(value:0,child:Text('Todas')),DropdownMenuItem(value:30,child:Text('Últimos 30 dias')),DropdownMenuItem(value:90,child:Text('Últimos 90 dias')),DropdownMenuItem(value:365,child:Text('Últimos 12 meses'))],onChanged:(v)=>setState(()=>periodo=v!)),FilledButton.icon(onPressed:()=>abrir(FormVenda(usuarioId:widget.usuarioId)),icon:const Icon(Icons.add),label:const Text('Nova venda'))]),Expanded(child:FutureBuilder<List<Registro>>(future:dados,builder:(c,s){if(s.hasError)return Center(child:Text('${s.error}'));if(!s.hasData)return const Center(child:CircularProgressIndicator());final limite=dataIso(DateTime.now().subtract(Duration(days:periodo)));final vendas=s.data!.where((v)=>('${v['cliente']} ${v['produto']}'.toLowerCase().contains(busca))&&(periodo==0||v['data_venda'].toString().compareTo(limite)>=0)).toList();if(vendas.isEmpty)return const Center(child:Text('Nenhuma venda encontrada.'));return ListView.builder(itemCount:vendas.length,itemBuilder:(c,i){final v=vendas[i];return Card(child:ListTile(title:Text('${v['cliente']} • ${v['produto']}'),subtitle:Text('${dataBr(v['data_venda'])} | ${v['quantidade']} ${v['unidade']}'),trailing:Text(dinheiro(v['valor_total'] as num)),onTap:()=>abrir(DetalheVenda(venda:v,usuarioId:widget.usuarioId))));});}))]);
}
class DetalheVenda extends StatelessWidget {
  final Registro venda; final int usuarioId;
  const DetalheVenda({super.key,required this.venda,required this.usuarioId});
  @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('Detalhes da venda')),body:ListView(padding:const EdgeInsets.all(20),children:[for(final e in {'Código':venda['id_venda'],'Cliente':venda['cliente'],'Produto':venda['produto'],'Vendedor':venda['vendedor'],'Quantidade':'${venda['quantidade']} ${venda['unidade']}','Valor unitário':dinheiro(venda['valor_unitario'] as num),'Valor total':dinheiro(venda['valor_total'] as num),'Data':dataBr(venda['data_venda'])}.entries)ListTile(title:Text(e.key),subtitle:Text('${e.value}')),FilledButton.icon(onPressed:()async{await Navigator.push(context,MaterialPageRoute(builder:(_)=>FormVenda(usuarioId:usuarioId,registro:venda)));if(context.mounted)Navigator.pop(context);},icon:const Icon(Icons.edit),label:const Text('Editar venda')),TextButton.icon(onPressed:()async{if(!await confirmar(context))return;try{await banco.excluir('venda',venda['id_venda'] as int);if(context.mounted)Navigator.pop(context);}catch(e){if(context.mounted)aviso(context,e);}},icon:const Icon(Icons.delete_outline),label:const Text('Excluir venda'))]));
}
class FormVenda extends StatefulWidget {
  final int usuarioId; final Registro? registro;
  const FormVenda({super.key,required this.usuarioId,this.registro});
  @override State<FormVenda> createState()=>_FormVendaState();
}
class _FormVendaState extends State<FormVenda>{
  final chave=GlobalKey<FormState>(); final qtd=TextEditingController();final valor=TextEditingController();
  int? cliente,produto; late DateTime dia; bool salvando=false;late Future<List<List<Registro>>> dados;
  @override void initState(){super.initState();final r=widget.registro;cliente=r?['id_cliente'] as int?;produto=r?['id_produto'] as int?;qtd.text=r?['quantidade']?.toString()??'';valor.text=r?['valor_unitario']?.toString()??'';dia=DateTime.tryParse(r?['data_venda']?.toString()??'')??DateTime.now();dados=Future.wait([banco.listar('cliente'),banco.listar('produto')]);}
  @override void dispose(){qtd.dispose();valor.dispose();super.dispose();}
  double get total=>(numero(qtd.text)??0)*(numero(valor.text)??0);
  Future<void> salvar()async{if(!chave.currentState!.validate())return;setState(()=>salvando=true);try{await banco.salvar('venda',{'id_cliente':cliente,'id_produto':produto,'id_usuario':widget.registro?['id_usuario']??widget.usuarioId,'quantidade':numero(qtd.text),'valor_unitario':numero(valor.text),'valor_total':(total*100).round()/100,'data_venda':dataIso(dia)},widget.registro?['id_venda'] as int?);if(mounted)Navigator.pop(context);}catch(e){if(mounted)aviso(context,e);}finally{if(mounted)setState(()=>salvando=false);}}
  Widget campo(TextEditingController t,String label,bool positivo)=>Padding(padding:const EdgeInsets.only(bottom:14),child:TextFormField(controller:t,keyboardType:const TextInputType.numberWithOptions(decimal:true),decoration:InputDecoration(labelText:label,border:const OutlineInputBorder()),onChanged:(_)=>setState((){}),validator:(v){final n=numero(v??'');if(n==null||!n.isFinite||n<0||(positivo&&n==0))return 'Informe um número válido';return null;}));
  @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:Text(widget.registro==null?'Nova venda':'Editar venda')),body:FutureBuilder<List<List<Registro>>>(future:dados,builder:(c,s){if(s.hasError)return Center(child:Text('${s.error}'));if(!s.hasData)return const Center(child:CircularProgressIndicator());final clientes=s.data![0],produtos=s.data![1];if(clientes.isEmpty||produtos.isEmpty)return Center(child:Padding(padding:const EdgeInsets.all(24),child:Column(mainAxisSize:MainAxisSize.min,children:[const Text('Cadastre pelo menos um cliente e um produto antes de registrar uma venda.'),TextButton(onPressed:()=>Navigator.pop(context),child:const Text('Voltar'))])));return Form(key:chave,child:ListView(padding:const EdgeInsets.all(20),children:[DropdownButtonFormField<int>(value:cliente,isExpanded:true,decoration:const InputDecoration(labelText:'Cliente',border:OutlineInputBorder()),items:[for(final r in clientes)DropdownMenuItem(value:r['id_cliente'] as int,child:Text('${r['nome']}',overflow:TextOverflow.ellipsis))],onChanged:(v)=>setState(()=>cliente=v),validator:(v)=>v==null?'Selecione o cliente':null),const SizedBox(height:14),DropdownButtonFormField<int>(value:produto,isExpanded:true,decoration:const InputDecoration(labelText:'Produto',border:OutlineInputBorder()),items:[for(final r in produtos)DropdownMenuItem(value:r['id_produto'] as int,child:Text('${r['nome']} (${r['unidade_medida']})',overflow:TextOverflow.ellipsis))],onChanged:(v)=>setState((){produto=v;if(v!=null)valor.text=produtos.firstWhere((r)=>r['id_produto']==v)['valor_unitario'].toString();}),validator:(v)=>v==null?'Selecione o produto':null),const SizedBox(height:14),campo(qtd,'Quantidade',true),campo(valor,'Valor unitário (R\$)',false),ListTile(contentPadding:EdgeInsets.zero,title:const Text('Data da venda'),subtitle:Text(dataBr(dataIso(dia))),trailing:const Icon(Icons.calendar_month),onTap:()async{final d=await showDatePicker(context:context,initialDate:dia,firstDate:DateTime(2000),lastDate:DateTime.now());if(d!=null&&mounted)setState(()=>dia=d);}),Card(child:ListTile(title:const Text('Valor total'),trailing:Text(dinheiro(total),style:const TextStyle(fontSize:22,fontWeight:FontWeight.bold)))),const SizedBox(height:16),FilledButton(onPressed:salvando?null:salvar,child:const Text('Salvar venda'))]));}));
}
