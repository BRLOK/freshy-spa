# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

User.destroy_all
Service.destroy_all
User.create([
  {
    name: "Admin",
    email: "admin@email.com",
    password: "123123",
    role: "admin",
    active: true
  }, {
    name: "Operador",
    email: "operador@email.com",
    password: "123123",
    role: "operator",
    active: true
  }, {
    name: "Colaborador 1",
    email: "colaborador1@email.com",
    password: "123123",
    role: "collaborator",
    active: true
  }, {
    name: "Colaborador 2",
    email: "colaborador2@email.com",
    password: "123123",
    role: "collaborator",
    active: true
  }
])
Service.create([
  {
    name: "Hidromassagem",
    description: %Q[
      Quando pensamos em relaxar depois de um dia estressante,
      a primeira coisa que vem em nossa mente é tomar um delicioso banho.
      A banheira usa a água para fazer massagem e renovar seu pique.
    ].squish,
    duration: 30,
    active: true
  }, {
    name: "Massagem relaxante",
    description: %Q[
      Esta técnica é realizada através de movimentos suaves,
      lentos e firmes no corpo inteiro, relaxando a musculatura e
      proporcionando alivio nas tensões e stress.
    ].squish,
    duration: 60,
    active: true
  }, {
    name: "Limpeza de pele",
    description: %Q[
      A limpeza de pele tem a finalidade de remover células mortas,
      dando mais viçosidade a pele. Auxilia no controle da oleosidade,
      a fim de prevenir e diminuir a quantidade de pústulas (espinhas),
      comedões (cravos) e milios. A extração é feita manualmente e utiliza
      vapor de ozônio e alta frequência.
    ].squish,
    duration: 90,
    active: true
  }, {
    name: "Shiatsu",
    description: %Q[
      Terapia oriental que visa equilibrar através de pressão digital
      os canais de energia que percorrem nosso corpo, trazendo bem-estar,
      alivio de dores musculares e tensões.
    ].squish,
    duration: 90,
    active: true
  }
])
User.where(role: "collaborator").each do |collaborator|
  collaborator.update(service_ids: Service.pluck(:id))
end
Customer.create([
  {
    name: "Maria",
    email: "maria@email.com",
    cpf: "54135422403",
    telephone: "(12) 34567890",
    active: true
  }, {
    name: "João",
    email: "joao@email.com",
    cpf: "22197137506",
    telephone: "(11) 987654321",
    active: true
  }
])
collaborator = User.find_by_role("collaborator")
Attendance.create([
  {
    customer_id: Customer.first.id,
    user_id: collaborator.id,
    scheduled_for: 2.days.from_now.beginning_of_day + 10.hours,
    status: "scheduled",
    items_attributes: [
      {
        service_id: collaborator.service_ids[0]
      },
      {
        service_id: collaborator.service_ids[1]
      },
      {
        service_id: collaborator.service_ids[2]
      }
    ]
  }
])
