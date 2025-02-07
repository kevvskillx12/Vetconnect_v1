using System;
using Microsoft.EntityFrameworkCore;
using VetConnect_v1.Data;
using VetConnect_v1.Mappings;
using AutoMapper;

var builder = WebApplication.CreateBuilder(args);

// Configurar CORS
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll", policy =>
    {
        policy.AllowAnyOrigin()
              .AllowAnyMethod()
              .AllowAnyHeader();
    });
});

// Configurar DbContext con cadena de conexión desde appsettings.json
builder.Services.AddDbContext<VeterinariaDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));


// Registrar AutoMapper
builder.Services.AddAutoMapper(typeof(AutoMapperProfile));

// Configurar controladores y Swagger

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Usar CORS antes de Swagger y otros middlewares
app.UseCors("AllowAll");

 //Configurar Swagger para todos los entornos
app.UseSwagger();
app.UseSwaggerUI(c =>
{
    c.SwaggerEndpoint("/swagger/v1/swagger.json", "VetConnect API V1");
});

app.UseAuthorization();
app.MapControllers();

Console.WriteLine($"Aplicación corriendo en el entorno: {app.Environment.EnvironmentName}");
Console.WriteLine("Accede a Swagger en: http://localhost:5233/swagger");

app.Run();
