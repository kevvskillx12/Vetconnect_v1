using System;
using System.IO;
using Microsoft.EntityFrameworkCore;
using VetConnect_v1.Data;
using VetConnect_v1.Mappings;
using AutoMapper;
using FirebaseAdmin;
using Google.Apis.Auth.OAuth2;
using VetConnect_v1.Services;

var builder = WebApplication.CreateBuilder(args);
// 🔹 Agregar configuración de appsettings.json
builder.Configuration.AddJsonFile("appsettings.json", optional: false, reloadOnChange: true);

var configuration = builder.Configuration; // ⬅️ Agregar esta línea

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

// 🔹 Agregar HttpClient y ChatbotService
builder.Services.AddHttpClient();
builder.Services.AddSingleton<ChatbotService>();

// Registrar el servicio de notificaciones
builder.Services.AddScoped<INotificationService, NotificationService>();

// Configurar controladores y Swagger
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// 🔹 Inicializar Firebase
try
{
    string firebaseConfigPath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "fir-vetconnect-android-firebase-adminsdk-fbsvc-1c3ab96db9.json");

    if (File.Exists(firebaseConfigPath))
    {
        FirebaseApp.Create(new AppOptions()
        {
            Credential = GoogleCredential.FromFile(firebaseConfigPath)
        });

        Console.WriteLine("✅ Firebase inicializado correctamente.");
    }
    else
    {
        Console.WriteLine("⚠️ Archivo de configuración de Firebase no encontrado.");
    }
}
catch (Exception ex)
{
    Console.WriteLine($"❌ Error al inicializar Firebase: {ex.Message}");
}

// Usar CORS antes de Swagger y otros middlewares
app.UseCors("AllowAll");

// Configurar Swagger para todos los entornos
app.UseSwagger();
app.UseSwaggerUI(c =>
{
    c.SwaggerEndpoint("/swagger/v1/swagger.json", "VetConnect API V1");
});

app.UseAuthorization();
app.MapControllers();

Console.WriteLine($"Aplicación corriendo en el entorno: {app.Environment.EnvironmentName}");
Console.WriteLine("Accede a Swagger en: http://localhost:5233/swagger");

// Ejemplo de uso del ChatbotService
var chatbotService = app.Services.GetRequiredService<ChatbotService>();
// Usar el servicio de chatbot
var respuesta = await chatbotService.ObtenerRespuestaIA("mi pregunta");
Console.WriteLine($"Respuesta del modelo seleccionado: {respuesta}");

app.Run();
